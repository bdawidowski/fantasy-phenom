class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  
  def current_user_contributor?
    current_user_subscribed? && current_user.contributor?
  end
  
  def current_user_admin?
    current_user_contributor? && current_user.admin?
  end
  
  helper_method :current_user_subscribed?, :current_user_admin?, :current_user_contributor?
  
  

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
end
