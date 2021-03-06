class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.debug "Article: #{request.env["omniauth.auth"]}"

    if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      puts @user.errors.messages
      if @user.admin?
        redirect_to admin_sign_up_path
      else
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    redirect_to root_path
  end

end
