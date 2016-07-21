class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
   	  t.date :expiry_date
   	  t.float :discount
   	  t.string :coupon_title
   	  t.string :coupon_condition_title
   	  t.integer :coupon_condition_rule
   	  t.string :coupons_slogan
   	  t.string :distributors
   	  t.integer :coupon_numbers_of_user
      t.timestamps null: false
    end
  end
end
