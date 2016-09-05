class Admin::BaseController < ApplicationController
	before_action :verify_admin
	before_action :current_store
	# before_action :verify_current_store
	layout "admin"







	private
	def verify_admin
	  	redirect_to admin_front_path unless current_user.try(:admin?)
	end
	def current_store
    	@current_store||=current_user.try(:stores).first#還要再改成有分店的
    	current_store_id||=@current_store.id
    	@current_admin_store||=Admin::Store.find(current_store_id)
  	end
  	# def verify_current_store
  	# 	redirect_to admin_home_path unless current_user.stores
  	# end
end
