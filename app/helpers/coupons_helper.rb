module CouponsHelper
	def distributor(coupon)
		if coupon.root?||coupon.parent.root?
			"店家發送"
		else
			link_to user_path(coupon.parent.user) do
				concat image_tag coupon.parent.user.avatar.url||"avatar.jpg", class: 'avatar coupon-profile-pic'
				concat " "
				concat coupon.parent.user.name
			end
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
	def coupon_carousel_active(index)
		if index==0
			"active" 
		end
	end	
end
