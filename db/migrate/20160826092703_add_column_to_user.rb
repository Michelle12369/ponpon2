class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :age, :integer
    add_column :users, :location, :string
  end
end
