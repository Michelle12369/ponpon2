class Admin::HomeController <Admin::BaseController
	def index

	end

	def operating_data
		@admin_coupons = @current_store.coupons.roots.order(created_at: :desc)
		@discount=0
		@admin_coupons.each do |coupon|
			coupon.descendants.where("used=?",true).each do |des_coupon|
				@discount+=des_coupon.computed_discount
			end
		end

	end
end
