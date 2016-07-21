class ChangeDiscountCeilingAmountType < ActiveRecord::Migration
  def change
  	change_column :coupons, :discount_ceiling_amount,:float
  end
end
