module CouponsHelper
	def distributor(coupon)
			if coupon.root?
				nil
			elsif coupon.parent.present?&&coupon.parent.root?
				"店家發送"
			elsif coupon.parent.user.nil?	
				"已被刪除的使用者"
			else
				link_to user_path(coupon.parent.user) do
					concat image_tag coupon.parent.user.avatar.url||"avatar.jpg", class: 'avatar coupon-profile-pic'
					concat " "
					concat coupon.parent.user.name
				end
			end	
	end
	
	def distributor2(coupon)
		if coupon.root?
			nil
		elsif coupon.parent.present?&&coupon.parent.root?
			concat image_tag "Qpon.png" , class: 'distributor_store' and "店家發送"
#			concat "店家"
		elsif coupon.parent.user.nil?	
			"已被刪除的使用者"	
		else
			concat image_tag coupon.parent.user.avatar.url||"avatar.jpg", class: 'avatar coupon-profile-pic distributor_store'
			concat coupon.parent.user.name and "發送"
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
	def coupon_distributed_number(coupon)
		if coupon.distributed_number.nil?||coupon.distributed_number<5
			true
		end	
	end
	def coupon_carousel_active(index)
		if index==0
			"active" 
		end
	end	
end
