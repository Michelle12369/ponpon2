class HomeController < ApplicationController
  before_action :set_user, except: :front
  respond_to :html, :js
  layout "frontbar", :only => :front

  def front
    #@activities = PublicActivity::Activity.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  
  end

  def index
    @post = Post.new
    @friends = @user.all_following.unshift(@user)
    @followers = User.all
    @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  
  end

  def food

  end

  def play

  end

  def online

  end

  def offical

  end  

  private
  def set_user
    @user = current_user
  end
end
