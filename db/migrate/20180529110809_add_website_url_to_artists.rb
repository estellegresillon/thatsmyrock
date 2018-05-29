class AddWebsiteUrlToArtists < ActiveRecord::Migration[5.2]
  def change
     add_column :artists, :website_url, :string
  end
end
