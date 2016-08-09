class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :store_phone
      t.string :store_address
      t.string :store_name
      t.string :store_keeper_name
      t.string :store_keeper_phone
      t.string :store_email
      t.string :store_about_string
      t.string :store_location
      t.text :store_time
      t.text :store_rule
      t.string :store_photo

      t.timestamps
    end

    add_column :users,:remote_avatar_url,:string
  end
end
