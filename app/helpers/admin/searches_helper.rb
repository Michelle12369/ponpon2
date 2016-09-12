module Admin::SearchesHelper
	def min_between_coupon_and_search(search_result,admin_coupon_limit)
		(search_result > admin_coupon_limit) ? admin_coupon_limit : search_result
	end
end
