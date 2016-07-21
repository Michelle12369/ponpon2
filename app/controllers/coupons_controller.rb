class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!
  load_and_authorize_resource

 

  # GET /coupons
  # GET /coupons.json

  def index
    @coupons = @user.coupons#Coupon.all

  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    #puts "hi this is #{params[:receiver_id]}"
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
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to [@coupon.user,@coupon], notice: 'Coupon was successfully destroyed.' }
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
      params.require(:coupon).permit(:coupon_title)
      #fetch(:coupon, {})
    end
end
