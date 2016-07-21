class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
acts_as_voter
has_many :comments

	acts_as_follower
  acts_as_followable
  has_many :posts

    mount_uploader :avatar, AvatarUploader
      mount_uploader :cover, AvatarUploader
end

