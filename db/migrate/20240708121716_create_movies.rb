class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.string :poster_url
      t.string :categorie_name
      t.boolean :status, default: :false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
