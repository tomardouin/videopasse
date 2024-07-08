class AddColToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :localisation, :string
    add_column :users, :username, :string
    add_column :users, :date_inscription, :date
  end
end
