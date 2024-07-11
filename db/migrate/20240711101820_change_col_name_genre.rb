class ChangeColNameGenre < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :genre_name, :string
  end
end
