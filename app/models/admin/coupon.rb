class Admin::Coupon < Coupon

	require 'rqrcode'
	require 'rqrcode_png'

	def self.sort_coupon(coupon,store)
		if store.fee_type=="plan_a"
			Admin::Coupon.create_coupon(coupon,0.05)
		elsif store.fee_type=="plan_b"
			Admin::Coupon.create_coupon(coupon,0.04)
		else	
			Admin::Coupon.create_coupon(coupon,0.03)
		end
		#店家qrcode
		url="https://pon-michelle12369.c9users.io/stores/#{store.id}/coupons/#{coupon.id}/take"
		@qrcode = RQRCode::QRCode.new(url,:size => 4, :level => :l)#用真的網址line才掃得到
		tmp_path = Rails.root.join("qrcode.png")
		png = @qrcode.to_img.resize(150, 150).save(tmp_path)
		# Stream is handed closed, we need to reopen it
		File.open(png.path) do |file|
		  coupon.update(qr_code:file)
		end
		File.delete(png.path)
	end

	def self.create_coupon(coupon,discount)

		#店家折數計算
	 	default_discount=coupon.computed_discount
		discount_ceiling_people=((1.2-default_discount)/discount).round
		coupon.update(used:false,discount: discount,discount_ceiling_people: discount_ceiling_people, discount_ceiling_amount: default_discount-0.2)
	end

end
