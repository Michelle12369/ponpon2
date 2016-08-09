class Admin::BaseController < ApplicationController
	before_filter :verify_admin
	before_action :current_store
	layout "admin"




	def current_store
    	#current_user ? current_user.stores : nil
    	@current_store||=current_user.try(:stores).first.id#還要再改成有分店的
  	end


	private
	def verify_admin
	  redirect_to admin_landing_path unless current_user.try(:admin?)
	end
end
