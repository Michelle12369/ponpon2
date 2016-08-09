class User < ActiveRecord::Base
  enum role: [:user,:admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  acts_as_voter
  has_many :comments

	acts_as_follower
  acts_as_followable
  has_many :posts

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader

  has_many :coupons#,:through=>:coupon_users
  #has_many :coupon_users

 def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  has_many :stores ,:through =>:store_users
  has_many :store_users
end

