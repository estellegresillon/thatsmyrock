class AddSpotifyalbumuriToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :spotify_album_uri, :integer
  end
end
