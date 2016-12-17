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
  has_many :comments,dependent: :destroy

	acts_as_follower
  acts_as_followable
  has_many :posts,dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, AvatarUploader
  validates_presence_of :name,:birthday,:message=>'不能為空白'
  
  has_many :coupons#,:through=>:coupon_users
  #has_many :coupon_users
  before_save :compute_age


 def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://')+ "?type=large" # assuming the user model has an image
      user.provider = auth.provider
      user.uid = auth.uid
      user.gender=auth.extra.raw_info.gender
      if auth.extra.raw_info.birthday.present?
        user.birthday=Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y')  
        user.age=(Date.today - user.birthday).to_i / 365
      end 
      user.location=auth.extra.raw_info.location.name if auth.extra.raw_info.location.present?
    end
  end

  def compute_age
    if self.birthday.present?&&self.age.nil?
      self.age=(Date.today - self.birthday).to_i / 365
    end
  end

#給活動用，註冊即送兩張優惠卷，第一個使用者註冊時可能會錯
  after_create :send_two_coupons
  def send_two_coupons
    if self.id!=1
      User.find(self.id).follow(Store.first)
      new_coupon=Coupon.copy_coupon(self.id,Store.first.coupons.roots[2])
      Coupon.qrcode(self.id,new_coupon)
      # new_coupon2=Coupon.copy_coupon(self.id,Store.first.coupons.roots[1])
      # Coupon.qrcode(self.id,new_coupon2)
    end
  end

  has_many :stores ,:through =>:store_users
  has_many :store_users
end

