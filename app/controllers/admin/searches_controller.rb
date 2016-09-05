class Admin::SearchesController < Admin::BaseController
	before_action :set_coupon
	before_action :verify_admin_coupon_notuse

	def new
		@search=Admin::Search.new
	end
	def create
		@search=Admin::Search.create(search_params)
		redirect_to admin_store_coupon_search_path(@current_store,@coupon,@search)
	end
	def show
		@search=Admin::Search.find(params[:id])

	end

	private
	def search_params
		params.require(:admin_search).permit(:gender,:location,:max_age,:min_age,:relation)
	end
	def set_coupon
      @coupon = Admin::Coupon.find(params[:coupon_id])
    end
    def verify_admin_coupon_notuse
      redirect_to admin_store_coupons_path unless @coupon.expiry_date>=Date.today&&@coupon.root?
    end
end
