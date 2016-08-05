class AddCouponPic < ActiveRecord::Migration
  def change
  	remove_column :users,:remote_avatar_url
  	add_column :coupons,:coupon_pic,:string
  end
end
