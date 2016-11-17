class PagesController < ApplicationController
	layout "nobar"
	def admin_landing
    	# render :layout => "nobar"
 	end 

 	def contract
 		redirect_to admin_front_path unless current_user.role=="user"&&current_user.stores[0].nil?
 	end

 	def complete_apply
 		redirect_to admin_front_path unless current_user.role=="user"&&current_user.stores[0].try(:store_status)=="pending"
 	end
 	def contract_content
 		render :layout => "iframebar"
 	end
 	def faq
 		render :layout => "application"
 	end
end
