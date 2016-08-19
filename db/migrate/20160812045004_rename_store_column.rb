class RenameStoreColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :stores, :store_about_string, :store_about
  	change_column :stores, :store_about,:text
  	rename_column :stores, :store_location, :store_type
  end
end
