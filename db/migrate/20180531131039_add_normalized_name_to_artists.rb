class AddNormalizedNameToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :normalized_name, :string
  end
end
