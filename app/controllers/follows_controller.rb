class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    if !params[:user_id].nil?
      @user = User.find(params[:user_id]) 
      current_user.follow(@user) 
    else
      @store=Store.find(params[:store_id])
      current_user.follow(@store)
    end
    respond_to do |format|
        format.js
        format.html { redirect_to root_path }
    end
  end

  def destroy
    if !params[:user_id].nil?
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    else
      @store=Store.find(params[:store_id])
      current_user.stop_following(@store)
    end
    respond_to do |format|
        format.js
        format.html { redirect_to root_path }
    end
  end

  
end
