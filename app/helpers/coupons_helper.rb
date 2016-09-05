module CouponsHelper
	def distributor(coupon)
		if coupon.root?||coupon.parent.root?
			"店家發送"
		else
			coupon.parent.user.name
		end	
	end
	def coupon_status(coupon)
		if coupon.used==true
			"已使用"
		elsif  coupon.expiry_date<Date.today
			"已過期"
		else
			"可使用"
		end
	end
end
