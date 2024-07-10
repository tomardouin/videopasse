class HeavlyModificationOnMovieTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :overview, :overview
    add_column :movies, :release_year, :integer
    remove_column :movies, :categorie_name
    add_column :movies, :genre_ids, :integer, array: true, default:[]
  end
end
