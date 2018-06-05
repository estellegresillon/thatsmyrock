class AddDeezeralbumidToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :deezer_album_id, :integer
  end
end
