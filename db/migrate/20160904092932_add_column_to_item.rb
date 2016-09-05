class AddColumnToItem < ActiveRecord::Migration[5.0]
  def change
  	add_column :items,:item_type,:string
  	add_column :stores,:fee_type,:integer
  	add_column :coupons,:admin_coupon_limit,:integer
  	remove_column :coupons,:condition_type
  	remove_column :coupons,:condition_content
  end
end
