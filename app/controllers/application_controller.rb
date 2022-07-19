class ApplicationController < ActionController::Base
# #ログイン認証が成功していない場合、トップページ以外画面は表示不可
# before_action :authenticate_user_or_admin, except: [:top]

before_action :configure_permitted_parameters, if: :devise_controller?

#サインイン後の遷移先の設定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      
      admin_movies_path
    when User
      
      movies_path
    end
  end

#サインアウト後の遷移先の設定
  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :user
      root_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # def authenticate_user_or_admin
  #   if user_signed_in? && admin_signed_in?
  #       redirect_to destroy_admin_session_path, method: :delete
  #     # redirect_to root_path
  #   else

  #   end
  # end
end
