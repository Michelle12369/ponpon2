class CreateAdminSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_searches do |t|
      t.string :location
      t.string :gender
      t.integer :relation
      t.integer :max_age
      t.integer :min_age
      t.timestamps
    end
  end
end
