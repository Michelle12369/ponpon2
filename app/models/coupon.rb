class Coupon < ActiveRecord::Base
  has_many :users,:through=>:coupon_users
  has_many :coupon_users
end
