class AddStoreToComment < ActiveRecord::Migration[5.0]
  def change
  	add_column :comments,:store_id,:integer
  	add_column :stores,:display,:boolean
  	add_column :items,:coupon_id,:integer
  end
end
