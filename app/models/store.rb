class Store < ActiveRecord::Base
	has_many :coupons
	acts_as_followable
	has_many :posts
	has_many :items
	# mount_uploaders :store_photo, AvatarUploader
	# crop_uploaded :store_photo

	has_many :users ,:through =>:store_users
	has_many :store_users
	validates_presence_of :store_phone, :store_address, :store_name, :store_keeper_name, :store_keeper_phone, :store_email, :store_type

	enum fee_type: [:plan_a,:plan_b,:plan_c]
	enum store_status: [:passed,:pending,:rejected]
	after_initialize :set_default_store, :if => :new_record?
	def set_default_store
    	self.store_status ||= :pending
    	self.fee_type ||= :plan_a
  	end


  	def change_store_status_to_passed
  		self.update(store_status: 0)
  		self.users.update(role:1)
  	end

	# attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
 #  	after_update :crop_store_photo

 #  	def crop_store_photo
 #    	store_photo.recreate_versions! if crop_x.present?
 #  	end



end
