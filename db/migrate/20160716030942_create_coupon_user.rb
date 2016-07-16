class CreateCouponUser < ActiveRecord::Migration
  def change
  	
    create_table :coupon_users do |t|
    	t.belongs_to :user
    	t.belongs_to :coupon

      t.timestamps null: false
    end
  end
end
