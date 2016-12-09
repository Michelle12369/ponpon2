class HomeController < ApplicationController
  before_action :set_user, except: :front
  respond_to :html, :js
  

  def front
    #正常寫法
    #@stores_last=Admin::Store.includes(:coupons).where(store_status:"passed").last(6)
    #@stores_first=Admin::Store.includes(:coupons).where(store_status:"passed").first(6)
    #for活動用
    @coupons=Coupon.includes(:store).first(2)
    render :layout => "frontbar"
    
    
  end

  def index
    @post = Post.new
    # @friends = @user.all_following.unshift(@user)
    @following_user=@user.following_users.to_a.unshift(@user)
    activity_user=PublicActivity::Activity.where(owner_id: @following_user,owner_type:"User")
    @following_store=@user.following_stores
    activity_store=PublicActivity::Activity.where(owner_id: @following_store,owner_type:"Store")
    @activities=activity_store.or(activity_user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    # @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @like_stores=Admin::Store.find(current_user.following_stores.ids.last(5))
    @commend_users=User.where.not(id:@following_user).sample(5)
  end

  def food
    @coupons=Coupon.roots.where("expiry_date >= ?",Time.zone.today).includes(:store).paginate(page: params[:page], per_page: 9)
  end

  def offical
  #正常寫法
    #@stores_last=Admin::Store.includes(:coupons).where(store_status:"passed").last(6)
    #@stores_first=Admin::Store.includes(:coupons).where(store_status:"passed").first(6)
    #for活動用
    @coupons=Coupon.includes(:store).first(2)
  end  

  def recommend
  end
  def recommend2
  end

  def search_user
    if params[:search].present?
      @results=User.where("lower(name) LIKE ?","%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 10)
      @results_store=Admin::Store.where("store_name LIKE ? and store_status=?","%#{params[:search]}%",0).paginate(page: params[:page], per_page: 10)
    end
    
  end


  private

  def set_user
    @user = current_user
  end
  
end
