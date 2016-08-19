class Admin::BaseController < ApplicationController
	before_action :verify_admin
	before_action :current_store
	layout "admin"







	private
	def verify_admin
	  redirect_to admin_front_path unless current_user.try(:admin?)
	end
	def current_store
    	@current_store||=current_user.try(:stores).first#還要再改成有分店的
  	end
end
