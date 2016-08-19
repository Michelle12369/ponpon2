class CustomFailure < Devise::FailureApp
  def redirect_url
    if request.referer.split("/")[3]=="admin"
      admin_sign_in_path#your_path
    else
       super
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect 

    end
  end
end