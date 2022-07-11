Rails.application.routes.draw do
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


scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  resources :movies, only: [:new, :create, :index, :show, :destroy] do
    resources :movie_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  post '/guests/guest_sign_in', to: 'guests#new_guest'
  resources :users, only: [:index, :show, :edit, :update]
end


end