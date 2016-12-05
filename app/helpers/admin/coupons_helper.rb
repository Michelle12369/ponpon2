module Admin::CouponsHelper
	def admin_coupon_status(admin_coupon)
		if admin_coupon.expiry_date<Date.today
			"已過期"
		else
			"進行中"
		end
	end
	#for活動用
	def send_or_delete(admin_coupon)
		if admin_coupon.expiry_date<Date.today
			link_to '刪除', admin_store_coupon_path(admin_coupon.store,admin_coupon), method: :delete, data: { confirm: '是否確認刪除此張優惠卷?' },class:"coupon-control-table-button-delete btn-use"
		# elsif admin_coupon.admin_coupon_limit>admin_coupon.descendants.size
		# 	link_to "發送", new_admin_store_coupon_search_path(admin_coupon.store,admin_coupon),class:"coupon-control-table-button-send"
		# else
		# 	"已發送完畢"
		else
			link_to "發送", new_admin_store_coupon_search_path(admin_coupon.store,admin_coupon),class:"coupon-control-table-button-send"
		end
		
	end
end
