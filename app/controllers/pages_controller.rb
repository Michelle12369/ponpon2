class PagesController < ApplicationController
	layout "nobar"
	def admin_landing
    	# render :layout => "nobar"
 	end 

 	def contract
 		
 	end

 	def complete_apply

 	end
 	def contract_content
 		render :layout => "iframebar"
 	end
 	def faq
 		render :layout => "application"
 	end
end
