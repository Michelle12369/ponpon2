class AddQrCodeToCoupon < ActiveRecord::Migration
  def change
  	add_column :coupons,:qr_code,:string
  end
end
