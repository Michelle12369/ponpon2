class Admin::CouponsController < Admin::BaseController
  before_action :set_admin_coupon, only: [ :edit, :destroy,:admin_send,:admin_confirm,:admin_redeem]
  before_action :set_store
  before_action :verify_admin_coupon_notuse,only: [:admin_send]
  #for活動用
  before_action :verify_admin_coupon_limit,only: [:admin_send]
  before_action :verify_user_coupon_notuse,only: [:admin_confirm,:admin_redeem]

  # GET /admin/coupons
  # GET /admin/coupons.json
  def index
    @admin_coupons = @store.coupons.roots.order(created_at: :desc)#Admin::Coupon.all
  end

  # GET /admin/coupons/1
  # GET /admin/coupons/1.json
  def show
    @admin_coupon = Coupon.find(params[:id]) 
    if @admin_coupon.user_id!=nil 
      redirect_to admin_store_coupons_path
    end
  end

  # GET /admin/coupons/new
  def new
    @admin_coupon = @store.coupons.build
  end

  # GET /admin/coupons/1/edit
  #crop時會需要
  def edit
  end

  # POST /admin/coupons
  # POST /admin/coupons.json
  def create
    @admin_coupon = @store.coupons.new(admin_coupon_params)
    

    respond_to do |format|
      if @admin_coupon.save
        Admin::Coupon.sort_coupon(@admin_coupon,@store)
        format.html { 
          if params[:coupon][:coupon_pic].present?
            render :crop
          else  
            redirect_to admin_store_coupons_path, notice: '已成功新增優惠卷'
          end 
            }
        format.json { render :show, status: :created, location: @admin_coupon }
      else
        format.html { render :new }
        format.json { render json: @admin_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/coupons/1
  # PATCH/PUT /admin/coupons/1.json
  #crop時會需要
  def update
    @admin_coupon = Admin::Coupon.find(params[:id])
    respond_to do |format|
      if @admin_coupon.update(admin_coupon_params)
        format.html { redirect_to admin_store_coupons_path, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_coupon }
      else
        format.html { render :edit }
        format.json { render json: @admin_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/coupons/1
  # DELETE /admin/coupons/1.json
  # def destroy
  #   @admin_coupon.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_store_coupons_path, notice: 'Coupon was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  #店家發送優惠卷
  def admin_send
    array=params[:range].split(' ')
    if params[:people].to_i<=array.size
      selected_users=array.sample(params[:people].to_i)
      selected_users.each do |receiver_id|
        new_coupon=Coupon.copy_coupon(receiver_id,@admin_coupon)
        Coupon.qrcode(receiver_id,new_coupon)
      end
    end  

    respond_to do |format|
        format.html { redirect_to admin_store_coupons_path, notice: '已成功發送' }
        format.json { render :show, status: :created, location: @coupon }
    end
  end

  #店家掃描顧客qrcode後跳出之頁面
  def admin_confirm
    
  end
  #店家掃描qrcode後跳出頁面裡面的兌換按鈕
  def admin_redeem
    ancs=@admin_coupon.ancestor_ids
    ancs.each_with_index do |anc,index|
      Coupon.calculate_discount(anc,index)
    end  
    # for i in ancs
    #   Coupon.calculate_discount(i,ancs.find_index(i))
    # end

    @admin_coupon.update(used: true)
    respond_to do |format|
      format.html { redirect_to admin_store_coupons_path, notice: '優惠卷已兌換' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_coupon
      @admin_coupon = Admin::Coupon.find(params[:id])
    end

    def set_store
      @store = Admin::Store.find(params[:store_id])
    end

    def verify_admin_coupon_notuse
      redirect_to admin_store_coupons_path, notice: '優惠卷已過期，無法發送給顧客' unless @admin_coupon.expiry_date>=Date.today
    end

    def verify_user_coupon_notuse
      redirect_to admin_store_coupons_path, alert: '顧客的優惠卷已被兌換或已過期，無法再兌換一次' unless @admin_coupon.used==false&&@admin_coupon.expiry_date>=Date.today
    end

    def verify_admin_coupon_limit
      redirect_to admin_store_coupons_path,notice:"店家優惠卷已發放完畢" unless @admin_coupon.admin_coupon_limit>@admin_coupon.descendants.size
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_coupon_params
      params.require(:coupon).permit(:crop_x,:crop_y,:crop_w,:crop_h,:coupon_title,:coupon_pic,:item,:start_date,:expiry_date,:other_content,:computed_discount,:admin_coupon_limit) 
    end
end
