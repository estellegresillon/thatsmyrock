class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.string :music_style
      t.integer :year
      t.integer :rank
      t.string :wiki_url
      t.string :photo_cover
      t.string :photo_show

      t.timestamps
    end
  end

end
