class DeleteCouponsDistributorsAndDropCouponUsers < ActiveRecord::Migration
  def change
  	drop_table :coupon_users
  	remove_column :coupons,:distributors
  end
end
