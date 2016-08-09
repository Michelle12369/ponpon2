class AddCouponToStore < ActiveRecord::Migration[5.0]
  def change
  	add_column :coupons,:store_id,:integer
  	add_column :posts,:store_id,:integer
  end
end
