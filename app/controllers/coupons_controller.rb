class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show,:redeem,:destroy,:distribute,:take]
  before_action :set_user,except: :take
  before_action :authenticate_user!
  before_action :verify_coupon_notuse,only: [:distribute,:redeem]
  # load_and_authorize_resource

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
    @coupon =@user.coupons.where("used = ? AND expiry_date < ?",false,Time.zone.today)
    @class="overdue"
    respond_to do |format|
      format.js {render "used.js.erb"}
      #format.html {render "index"}
    end
  end


  # GET /coupons/1
  # GET /coupons/1.json
  def show
    # have_coupon_user=User.joins(:coupons).where(coupons: {id:@coupon.descendant_ids })
    user_following=@user.following_users
    user_followed_by=@user.followers
    @friends=(user_following+user_followed_by).uniq
    @friends_array=@friends.pluck(:name,:id)
  end

  # GET /coupons/new
  # def new
  #   @coupon = @user.coupons.build#Coupon.new
  # end

  # GET /coupons/1/edit
  # def edit
  # end

  def distribute
    receiver_id=Integer(params[:receiver_id]) if params[:receiver_id]!=nil
    receiver_id||=params[:user_id]
    @new_coupon=Coupon.copy_coupon(receiver_id,@coupon)
    Coupon.qrcode(receiver_id,@new_coupon)
    respond_to do |format|
        format.html { redirect_to user_coupons_path(@user), notice: 'Coupon was successfully distributed.' }
        format.json { render :show, status: :created, location: @coupon }
    end
  end
  
  def redeem

  end

  def take
    @store=Store.find(params[:store_id])
  end

  # POST /coupons
  # POST /coupons.json
  # def create
  #   @coupon = @user.coupons.new(coupon_params)#Coupon.new(coupon_params)
    
  #   respond_to do |format|
  #     if @coupon.save
  #       format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully created.' }
  #       format.json { render :show, status: :created, location: @coupon }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @coupon.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  # def update
  #   respond_to do |format|
  #     if @coupon.update(coupon_params)
  #       format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @coupon }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @coupon.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  # def destroy
  #   ancs=@coupon.ancestor_ids
  #   for i in ancs
  #     Coupon.calculate_discount(i,ancs.find_index(i))
  #   end

  #   @coupon.update(used: true)

  #   #@coupon.destroy
  #   respond_to do |format|
  #     format.html { redirect_to [@coupon.user,@coupon], notice: '優惠卷已兌換' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def verify_coupon_notuse
      redirect_to user_coupon_path unless @coupon.used==false&&@coupon.expiry_date>=Date.today
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:coupon_title,:coupon_pic)
      #fetch(:coupon, {})
    end

end
