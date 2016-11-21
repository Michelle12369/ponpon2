class Admin::StoresController < Admin::BaseController
  before_action :set_admin_store, only: [ :edit, :update, :destroy]

  # # GET /admin/stores
  # # GET /admin/stores.json
  # def index
  #   @admin_stores = Admin::Store.all
  # end

  # # GET /admin/stores/1
  # # GET /admin/stores/1.json
  def show
  end

  # GET /admin/stores/new
  def new
    @admin_store = Admin::Store.new
  end

  # GET /admin/stores/1/edit
  def edit
    #@city_array=["基隆市","台北市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","台東縣","花蓮縣","宜蘭縣","澎湖縣","金門縣","連江縣"]
  end

  # POST /admin/stores
  # POST /admin/stores.json
  def create
    @admin_store = Admin::Store.new(admin_store_params)
    respond_to do |format|
      if @admin_store.save
        format.html { redirect_to @admin_store, notice: '已創建店家資訊' }
        format.json { render :show, status: :created, location: @admin_store }
      else
        format.html { render :new }
        format.json { render json: @admin_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stores/1
  # PATCH/PUT /admin/stores/1.json
  def update
    # @admin_store.store_address=params[:city]+params[:address]
    respond_to do |format|
      if @admin_store.update(admin_store_params)
        format.html { 
          if params[:admin_store][:store_cover_photo].present?
            render :crop  ## Render the view for cropping
          else
            redirect_to edit_admin_store_path, notice: '已更新店家資訊'
          end 
        }

        format.json { render :show, status: :ok, location: @admin_store }
      else
        format.html { render :edit }
        format.json { render json: @admin_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stores/1
  # DELETE /admin/stores/1.json
  # def destroy
  #   @admin_store.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_stores_url, notice: 'Store was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_store
      @admin_store = Admin::Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_store_params
      params.require(:admin_store).permit(:crop_x,:crop_y,:crop_w,:crop_h,:store_city,:store_phone, :store_address, :store_name, :store_keeper_name, :store_keeper_phone, :store_email, :store_about, :store_type, :store_time, :store_rule, {store_photo:[]},:store_cover_photo)
    end
end
