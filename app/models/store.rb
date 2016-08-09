class Store < ApplicationRecord
	has_many :coupons
	acts_as_followable
	has_many :posts
	mount_uploader :store_photo, AvatarUploader
	has_many :users ,:through =>:store_users
	has_many :store_users
end
