class Admin::Store < Store
	#self.table_name = 'adminstores'
	mount_uploaders :store_photo, AvatarUploader
	mount_uploader :store_cover_photo, AvatarUploader

	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  	after_update :crop_store_photo

  	def crop_store_photo
  		# store_photo.each do |pic|
    		store_cover_photo.recreate_versions! if crop_x.present?
    	# end
  	end
end
