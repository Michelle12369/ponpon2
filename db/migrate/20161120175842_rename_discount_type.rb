class RenameDiscountType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :coupons, :discount_type, :distributed_number
  end
end
