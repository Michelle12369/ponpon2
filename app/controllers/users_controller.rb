# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :check_ownership, only: [:edit, :update]
  respond_to :html, :js

  def show
    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @post_size= PublicActivity::Activity.where(owner: @user).order(created_at: :desc).size
  end

  def edit
    @city_array=["基隆市","台北市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","台東縣","花蓮縣","宜蘭縣","澎湖縣","金門縣","連江縣"]
  
  end

  def update

    if @user.update(user_params)
      redirect_to edit_user_path(@user),notice: "已成功更新使用者資料"
    else
      flash.now[:alert]="無法更新資料"
      render :edit
    end
  end

  def deactivate
  end

  def friends
    @friends = @user.following_users.paginate(page: params[:page])
  end

  def followers
    @followers = @user.user_followers.paginate(page: params[:page])
  end

  def stores
    @like_stores=@user.following_stores.paginate(page:params[:page])
  end

  def mentionable
    render json: @user.following_users.as_json(only: [:id, :name]), root: false
  end

  private
  def user_params
    params.require(:user).permit(:name, :about, :avatar,
                                 :gender, :age, :location)
  end

  def check_ownership
    redirect_to current_user, notice: '沒有授權' unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
