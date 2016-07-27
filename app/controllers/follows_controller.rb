class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    respond_to do |format|
        format.js
        format.html { redirect_to root_path }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    respond_to do |format|
        format.js
        format.html { redirect_to root_path }
    end
  end

  
end
