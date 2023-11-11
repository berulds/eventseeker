class UpdateGenreTypeColumnToGenreType < ActiveRecord::Migration[7.0]
  def change
    rename_column :genres, :type, :genre_type
  end
end
