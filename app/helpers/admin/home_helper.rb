module Admin::HomeHelper
	def calculate_rate(coupon)
		if coupon.descendants.where("used=?",true).size!=0
			number_to_percentage((coupon.descendants.where("used=?",true).size.to_f/coupon.descendants.size.to_f)*10)
		else
			number_to_percentage(0)
		end
	end
end
