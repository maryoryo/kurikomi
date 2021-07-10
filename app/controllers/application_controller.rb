class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when User
      user_path(current_user)
    end
  end
  
  # def after_sign_out_path_for(resource)
  #   case resource
  #   when :admin
  #     new_admin_session_path
  #   when :customer
  #     root_path
  #   end
  # end
  
  
  protected
  
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  
  
end
