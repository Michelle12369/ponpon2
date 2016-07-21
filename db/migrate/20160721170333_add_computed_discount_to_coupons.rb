class AddComputedDiscountToCoupons < ActiveRecord::Migration
  def change
  	add_column :coupons,:computed_discount,:float
  end
end
