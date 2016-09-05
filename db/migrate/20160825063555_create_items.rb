class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :item_price
      t.string :item_name
      t.text :item_about
      t.belongs_to :store
      t.timestamps
    end
    add_column :stores,:store_city,:string
  end
end
