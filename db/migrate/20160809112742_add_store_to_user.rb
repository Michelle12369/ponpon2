class AddStoreToUser < ActiveRecord::Migration[5.0]
  def change
  	create_table :store_users do |t|
      t.belongs_to :store
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
