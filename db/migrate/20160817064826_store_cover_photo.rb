class StoreCoverPhoto < ActiveRecord::Migration[5.0]
  def change
  	add_column :stores,:store_cover_photo,:string
  end
end
