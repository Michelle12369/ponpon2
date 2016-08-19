class RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

# ##註冊沒有輸入完整資訊的導向
#   def create
#     build_resource

#     if resource.save
#       if resource.active_for_authentication?     
#         set_flash_message :notice, :signed_up if is_navigational_format?
#         sign_in(resource_name, resource)
#         respond_with resource, :location => redirect_location(resource_name, resource)
#       else
#         set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
#         expire_session_data_after_sign_in!
#         respond_with resource, :location => after_inactive_sign_up_path_for(resource)
#       end
#     else
#       clean_up_passwords(resource)
#       # Solution for displaying Devise errors on the homepage found on:
#       # http://stackoverflow.com/questions/4101641/rails-devise-handling-devise-error-messages
#       flash[:notice] =  resource.errors.full_messages.first #flash[:notice].to_a.concat
#       if request.referer.split("/")[3]=="admin"
#         redirect_to admin_sign_up_path # HERE IS THE PATH YOU WANT TO CHANGE
#       else
#         redirect_to new_user_registration_path
#       end
#     end
#   end



  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if request.referer.split("/")[3]=="admin"
      puts "hihihihi"+resource.to_s
      admin_front_path
    else 
      super(resource)
    end
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    #super(resource)
    if request.referer.split("/")[3]=="admin"
      admin_sign_up_path
    else 
      super(resource)
    end
  end
end
