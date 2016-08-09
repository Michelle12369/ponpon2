class Admin::StoresController < Admin::BaseController
  before_action :set_admin_store, only: [:show, :edit, :update, :destroy]

  # GET /admin/stores
  # GET /admin/stores.json
  def index
    @admin_stores = Admin::Store.all
  end

  # GET /admin/stores/1
  # GET /admin/stores/1.json
  def show
  end

  # GET /admin/stores/new
  def new
    @admin_store = Admin::Store.new
  end

  # GET /admin/stores/1/edit
  def edit
  end

  # POST /admin/stores
  # POST /admin/stores.json
  def create
    @admin_store = Admin::Store.new(admin_store_params)

    respond_to do |format|
      if @admin_store.save
        format.html { redirect_to @admin_store, notice: 'Store was successfully created.' }
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
    respond_to do |format|
      if @admin_store.update(admin_store_params)
        format.html { redirect_to @admin_store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_store }
      else
        format.html { render :edit }
        format.json { render json: @admin_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stores/1
  # DELETE /admin/stores/1.json
  def destroy
    @admin_store.destroy
    respond_to do |format|
      format.html { redirect_to admin_stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_store
      @admin_store = Admin::Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_store_params
      params.fetch(:admin_store, {})
    end
end
