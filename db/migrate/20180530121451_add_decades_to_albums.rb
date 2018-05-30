class AddDecadesToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :decades, :integer
  end
end
