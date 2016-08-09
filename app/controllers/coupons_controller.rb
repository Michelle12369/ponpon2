class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy,:redeem]
  before_action :set_user
  before_action :authenticate_user!
  load_and_authorize_resource
require 'rqrcode'
require 'rqrcode_png'

  # GET /coupons
  # GET /coupons.json

  def index
    @coupon = @user.coupons.where("used = ? AND expiry_date > ?",false,Time.zone.today)#Coupon.all
  end

  def notuse
    @coupon = @user.coupons.where("used = ? AND expiry_date > ?",false,Time.zone.today)
    @class="notuse"
    respond_to do |format|
      format.js {render "used.js.erb"}
      #format.html {render "index"}
    end
  end

  def used
    @coupon = @user.coupons.where("used = ?",true)
    @class="used"
    respond_to do |format|
      format.js 
      #format.html {render "index"}
    end
  end

  def overdue
    @coupon =@user.coupons.where("expiry_date < ?",Time.zone.today)
    @class="overdue"
    respond_to do |format|
      format.js {render "used.js.erb"}
      #format.html {render "index"}
    end

  end


  # GET /coupons/1
  # GET /coupons/1.json
  def show
    if @coupon.parent.root?
       @distributor_name="店家發行"
    else
      @distributor_name=@coupon.parent.user.name
    end

    @followers = @user.all_following
  end

  # GET /coupons/new
  def new
    @coupon = @user.coupons.build#Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  def distribute
    @new_coupon=Coupon.copy_coupon(Integer(params[:receiver_id]),@coupon)
    url="https://pon-michelle12369.c9users.io/users/#{params[:user_id]}/coupons/#{params[:id]}"
    @qrcode = RQRCode::QRCode.new(url,:size => 4, :level => :l)#用真的網址line才掃得到，還要真正輸出png黨存到資料庫
    tmp_path = Rails.root.join("qrcode.png")
    png = @qrcode.to_img.resize(150, 150).save(tmp_path)
    # Stream is handed closed, we need to reopen it
    File.open(png.path) do |file|
      @new_coupon.qr_code = file
    end
    File.delete(png.path)

    respond_to do |format|
      if @new_coupon.try(:save)
        format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully distributed.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { redirect_to [@coupon.user,@coupon], notice: '不能自己發給自己.' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def redeem

  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = @user.coupons.new(coupon_params)#Coupon.new(coupon_params)
    
    respond_to do |format|
      if @coupon.save
        format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    ancs=@coupon.ancestor_ids
    for i in ancs
      Coupon.calculate_discount(i,ancs.find_index(i))
    end

    @coupon.update(used: true)

    #@coupon.destroy
    respond_to do |format|
      format.html { redirect_to [@coupon.user,@coupon], notice: '優惠卷已兌換' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:coupon_title,:coupon_pic)
      #fetch(:coupon, {})
    end
end
