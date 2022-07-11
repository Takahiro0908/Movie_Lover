class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?

#サインイン後の遷移先の設定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
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
end
