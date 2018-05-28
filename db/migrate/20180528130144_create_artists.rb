class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :facebook_url
      t.string :wiki_url
      t.text :bio
      t.string :instagram_url
      t.string :twitter_url
      t.string :photo
      t.string :country

      t.timestamps
    end
  end
end
