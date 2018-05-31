class AddNormalizedNameToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :normalized_name, :string
  end
end
