class AddUserforeignKeyToCoupon < ActiveRecord::Migration
  def change
  	add_column :coupons,:user_id,:integer
  end
end
