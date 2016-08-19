class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
def after_sign_in_path_for(resource)
  if resource.is_a?(User) && resource.admin? && request.referer.split("/")[3]=="admin"
    admin_home_path
  elsif resource.is_a?(User)  && resource.user? && request.referer.split("/")[3]=="admin"
    admin_front_path
  else
    super(resource)
  end
end


def after_sign_out_path_for(resource)
  puts request.referer.split("/")[3] 
   if request.referer.split("/")[3]=="admin" || request.referer.split("/")[3]=="admin-landing" #怕有可能會有些不是第三個/
     admin_front_path
  else
    super
   end
end


  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,keys: [:email, :remember_me])
  end

  include PublicActivity::StoreController

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_to root_url, :alert => exception.message
  end
end
