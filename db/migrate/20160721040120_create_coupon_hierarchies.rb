class CreateCouponHierarchies < ActiveRecord::Migration
  def change
    create_table :coupon_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :coupon_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "coupon_anc_desc_idx"

    add_index :coupon_hierarchies, [:descendant_id],
      name: "coupon_desc_idx"
  end
end
