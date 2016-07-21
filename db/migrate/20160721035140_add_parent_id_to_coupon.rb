class AddParentIdToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :parent_id, :integer
  end
end
