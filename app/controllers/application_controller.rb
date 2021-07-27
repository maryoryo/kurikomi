class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  # ログイン後の画面遷移先を記述
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when User
      user_path(current_user)
    end
  end
  
  
  protected
  
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
