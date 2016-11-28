class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show,:destroy,:distribute,:take,:download]
  before_action :set_user,except: :take
  before_action :authenticate_user!
  before_action :verify_coupon_notuse,only: [:distribute]
  before_action :verify_admin_coupon_limit,only: [:take]
  before_action :verify_admin_coupon_taken,only: [:take]
  load_and_authorize_resource

  # GET /coupons
  # GET /coupons.json
  def index
    @coupon = @user.coupons.where("used = ? AND expiry_date > ?",false,Time.zone.today).paginate(:page =>params[:page], :per_page=> 9)#Coupon.all
  end

  def used
    @coupon = @user.coupons.where("used = ?",true).paginate(:page =>params[:page], :per_page=> 9)
  end

  def overdue
    @coupon =@user.coupons.where("used = ? AND expiry_date < ?",false,Time.zone.today).paginate(:page =>params[:page], :per_page=> 9)
  end

#require 'will_paginate/array'
  # GET /coupons/1
  # GET /coupons/1.json
  def show
    # have_coupon_user=User.joins(:coupons).where(coupons: {id:@coupon.root.descendant_ids })
    store=@coupon.store_id
    @store=Admin::Store.find(store)
    if @coupon.user.present?
      user_following=@user.following_users
      user_followed_by=@user.user_followers
      @friends=(user_following+user_followed_by).uniq
      @friends.delete(@coupon.parent.user) if @friends.include?@coupon.parent.user
      @friends_array=@friends.pluck(:name,:id)#.paginate(:page =>params[:page], :per_page=> 10)
      @post = Post.new
    end
    @used_descendants=@coupon.descendants.where(used:true).includes(:user)
  end

  #顧客發送優惠卷給其他顧客
  def distribute
    receiver_id=Integer(params[:receiver_id]) if !params[:receiver_id].nil?
    receiver_id||=current_user.id#params[:user_id]
    @new_coupon=Coupon.copy_coupon(receiver_id,@coupon)
    Coupon.qrcode(receiver_id,@new_coupon)
    respond_to do |format|
        format.html { redirect_to user_coupon_path, notice: '恭喜您已成功發送/獲得優惠卷！' }
        format.json { render :show, status: :created, location: @coupon }
    end
  end
  
  #顧客要兌換優惠卷的頁面（有qrcode那頁）
  # def redeem

  # end

  #顧客下載自己的qrcode
require 'open-uri'
  def download
    if Rails.env.development?#本機壞掉
      send_file @coupon.qr_code.url, :type => 'image/jpeg', :disposition => 'attachment'
    end
    if Rails.env.production?
      url=@coupon.qr_code.url#Cloudinary::Utils.unsigned_download_url @coupon.qr_code.public_id#, @coupon.qr_code.format
      data = open(url).read
      send_data data, :disposition => 'attachment', :filename=>"#{@coupon.user.name}的#{@coupon.coupon_title}優惠卷.jpg"
    end
  end

  #顧客用qrcode掃描店家優惠卷後跳出頁面
  def take
    @store=Store.find(params[:store_id])
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def set_user
       @user = current_user#User.find(params[:user_id])
    end

    def verify_coupon_notuse
      redirect_to user_coupon_path unless @coupon.used==false&&@coupon.expiry_date>=Date.today
    end

    def verify_admin_coupon_limit
      redirect_to coupons_path,alert:"店家優惠卷已發放完畢，若想領取請向店家反應" unless @coupon.admin_coupon_limit>@coupon.descendants.size
    end

    def verify_admin_coupon_taken
      if User.joins(:coupons).where(coupons: {id:@coupon.child_ids }).include?(current_user)&&@coupon.children.where(user:current_user).where("used=? and expiry_date>=?",false,Date.today).present?
        redirect_to coupons_path,alert:"已經向店家領取過此優惠卷"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:coupon_title,:coupon_pic)
    end

end
