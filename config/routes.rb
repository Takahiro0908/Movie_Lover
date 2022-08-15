Rails.application.routes.draw do
  resources :events
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :movies, only: [:index, :show, :edit, :update] do
      resources :movie_comments, only: [:destroy]
    end
    resources :genres, only: [:index, :edit, :create, :update]
    # root to: 'homes#top'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :movies, only: [:new, :create, :index, :show, :destroy] do
      collection do
        get 'search' #検索結果のページへ遷移
        get 'search_tmdb'
        get 'detail' 
      end
      resources :movie_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :check
        #ユーザーの会員状況を取得
        patch :withdrawl
        #ユーザーの会員状況を更新
        get :favorites
      end
    end
  end

   devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


end