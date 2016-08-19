module PagesHelper
	def render_admin_link
	    if signed_in?&&current_user.admin?
	         concat link_to "進入店家系統",admin_home_path,class: "nav-link" 
	         concat " "
	         concat link_to "登出", admin_sign_out_path,method: :delete

	    elsif signed_in?&&current_user.user?&&current_user.stores.first.try(:store_status)=="pending"
	    	"您的申請正在審核中"
	        concat link_to "登出", admin_sign_out_path,method: :delete
	        concat " "
	        concat link_to "回到個人頁面", root_path

	    elsif signed_in?&&current_user.user?
	    	concat link_to "申請成為店家", new_store_path
	    	concat " "
	    	concat link_to "登出", admin_sign_out_path,method: :delete
	    	concat " "
	    	concat link_to "回到個人頁面", root_path
	   	else    
	   		concat link_to "登入", admin_sign_in_path
	   		concat " "
	   		concat link_to "註冊", admin_sign_up_path
	    end
	end
  
end
