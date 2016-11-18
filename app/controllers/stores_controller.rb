class StoresController < ApplicationController
  before_action :set_store, only: [:show]#, :edit, :update, :destroy]
  before_action :verify_apply_exist,only:[:new]
  
  # GET /stores
  # GET /stores.json
  def index
    @admin_stores = Admin::Store.where(:store_status => "passed")#.select("id,store_cover_photo")
    @stores=Store.where(:store_status=>"passed")
    @store=Hash[@admin_stores.zip(@stores)]
  end

  # # GET /stores/1
  # # GET /stores/1.json
  def show
    @admin_store_pic = Admin::Store.find(params[:id])
    @coupons=@admin_store_pic.coupons.roots
    @post = Post.new
    activity_store=PublicActivity::Activity.where(owner_id: @admin_store_pic ,owner_type:"Store")
    @activities=activity_store.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /stores/new
  def new
    redirect_to admin_front_path unless current_user.role=="user"&&current_user.stores[0].nil?
    @store = Store.new
    render :layout => "nobar"
  end

  # # GET /stores/1/edit
  # def edit
  # end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    @store.users<<current_user

    respond_to do |format|
      if @store.save
        format.html { redirect_to complete_apply_path }
        #format.json { render :show, status: :created, location: @store }
        format.js 
      else
        format.html { render :new }
        # format.json { render json: @store.errors, status: :unprocessable_entity }
        format.js { render :action => 'create_fail' }
      end
    end

  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  # def update
  #   respond_to do |format|
  #     if @store.update(store_params)
  #       format.html { redirect_to @store, notice: 'Store was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @store }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @store.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /stores/1
  # DELETE /stores/1.json
  # def destroy
  #   @store.destroy
  #   respond_to do |format|
  #     format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:store_phone, :store_address, :store_name, :store_keeper_name, :store_keeper_phone, :store_email, :store_type)
    end

    def verify_apply_exist
      redirect_to admin_front_path unless current_user.stores.empty?
    end
end
