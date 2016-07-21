class UpdateCouponColumn < ActiveRecord::Migration
  def change
  	add_column :coupons,:item, :string
  	add_column :coupons,:start_date, :date
  	add_column :coupons,:discount_type,:integer
  	add_column :coupons,:discount_ceiling_people,:integer
  	add_column :coupons,:discount_ceiling_amount,:integer
  	add_column :coupons,:condition_type,:integer
  	add_column :coupons,:condition_content,:string
  	add_column :coupons,:other_content,:text
  	add_column :coupons,:used,:boolean
  	remove_column :coupons,:coupon_condition_title
  	remove_column :coupons,:coupon_condition_rule
  	remove_column :coupons,:coupons_slogan
  	remove_column :coupons,:coupon_numbers_of_user
  end
end
