class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  before_filter :set_counters
  before_action :set_counters, if: :current_user_editor?
  def set_counters 
    @num_pending = Article.where(:approved => false).count
    @num_articles = Article.all.count
    @num_contacts = Contact.all.count
    @num_users = User.all.count
  end
  
  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end
  
  def current_user_contributor?
    current_user_subscribed? && current_user.contributor?
  end
  
  def current_user_editor?
    current_user_contributor? && current_user.editor?
  end
  
  def current_user_admin?
    current_user_editor? && current_user.admin?
  end
  
  def is_admin?
      if !current_user_admin?
          flash[:danger] = "Admin Only!"
          redirect_to root_path
      end
  end
  def is_contributor?
      if !current_user_contributor?
          flash[:danger] = "Contributors & Admin Only!"
          redirect_to root_path
      end
  end
  def is_editor?
      if !current_user_editor?
          flash[:danger] = "Admin Only!"
          redirect_to root_path
      end
  end

  def is_subscribed?
      if !current_user_subscribed?
          flash[:warning] = "You must be subscribed to access! Please Subscribe!"
          redirect_to new_subscription_path
      end
  end
  helper_method :current_user_subscribed?, 
    :current_user_admin?, 
    :current_user_contributor?, 
    :current_user_editor?, 
    :is_admin?, 
    :is_contributor?, 
    :is_subscribed?,
    :is_editor?
  
  

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
end
