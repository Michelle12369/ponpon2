class ChangeStorePhotoType < ActiveRecord::Migration[5.0]
  def change
  	change_column :stores,:store_photo,'json USING CAST(store_photo AS json)'
  end
end
