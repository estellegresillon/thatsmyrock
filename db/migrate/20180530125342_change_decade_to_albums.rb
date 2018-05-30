class ChangeDecadeToAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :decades, :decade
  end
end
