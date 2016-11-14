module PagesHelper
	def render_admin_link
	    if signed_in?&&current_user.admin?
	    	concat link_to "登出", admin_sign_out_path,method: :delete,class: 'admin-sign'
	    	concat " "
	        concat link_to "進入店家系統",admin_home_path,class: 'admin-sign'
	    elsif signed_in?&&current_user.user?&&current_user.stores.first.try(:store_status)=="pending"
	    	concat link_to "登出", admin_sign_out_path,method: :delete,class: 'admin-sign'
	        concat " "
	        concat link_to "回到個人頁面", root_path,class: 'admin-sign'
	        concat " "
	    	concat "您的申請正在審核中",class: 'admin-sign'
	    elsif signed_in?&&current_user.user?
	    	concat link_to "登出", admin_sign_out_path,method: :delete,class: 'admin-sign'
	    	concat " "
	    	concat link_to "回到個人頁面", root_path,class: 'admin-sign'
	    	concat " "
	    	concat link_to "申請成為店家", contract_path,class: 'admin-sign'
	    	
	   	else    
	   		concat link_to "登入", admin_sign_in_path,class: 'admin-sign'
	   		concat " "
	   		concat link_to "註冊", admin_sign_up_path,class: 'admin-sign'
	   		# concat "先註冊個人帳號再取得商家帳號吧"
	    end
	end
  
end
