class AddStoreStatusToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :store_status, :int
  end
end
