require 'csv'

# Parsing options
csv_options = {
  col_sep: ';',
  quote_char: '"',
  headers: :first_row,
  header_converters: :symbol
}

puts "Cleaning database..."
Artist.destroy_all

puts "Creating artists..."
filepath = Rails.root.join('db/fixtures/csv/artists.csv')

CSV.foreach(filepath, csv_options) do |row|
  artist = Artist.new(
    name: row[:name],
    country: row[:country],
    facebook_url: row[:facebook_url],
    instagram_url: row[:instagram_url],
    twitter_url: row[:twitter_url],
    website_url: row[:website_url],
    wiki_url: row[:wiki_url],
    bio: row[:bio]
    # photo: row[:photo],
  )

  begin
    # photo_title = "#{row[:name].downcase.gsub(' ', '-')}"
    photo_title = I18n.transliterate(row[:name].gsub('&', 'and').parameterize)
    photo = Cloudinary::Uploader.upload("db/fixtures/images/artists/#{photo_title}.jpg", :use_filename => true, :folder => "thatsmyrock/artists")
    artist.remote_photo_url = photo['url']
  rescue
    puts "No photo for #{row[:name]}"
  end

    row << ['Name', 'Appearance', 'Origin']
    row << ['Asahi', 'Pale Lager', 'Japan']
    row << ['Guinness', 'Stout', 'Ireland']

    artist.save!
end




puts "Creating albums..."
filepath = Rails.root.join('db/fixtures/csv/albums.csv')

CSV.foreach(filepath, csv_options) do |row|
  # album-name-artist-name.jpg

  # 1) Trouver l'artiste correspondatn au nom d'artiste dans le csv
  puts row[:artist]
  artist = Artist.find_by(name: row[:artist])
  # 2) Créer un album avec l'artiste_id correspondant
  album = Album.new(
    artist: artist,
    rank: row[:rank],
    name: row[:name],
    year: row[:year],
    music_style: row[:music_style],
    wiki_url: row[:wiki_url],
    description: row[:description]
    # photo_cover: row[:photo_cover],
    # photo_show: row[:photo_show],
  )
  begin
    # photo_title = "#{row[:name]}-#{row[:artist]}".downcase.gsub(' ', '-')
    photo_title = "#{I18n.transliterate(row[:name].gsub('&', 'and').parameterize)}-#{I18n.transliterate(row[:artist].gsub('&', 'and').parameterize)}"
    photo_cover = Cloudinary::Uploader.upload("db/fixtures/images/artists/#{photo_title}.jpg", :use_filename => true, :folder => "thatsmyrock/albums")
    album.remote_photo_cover_url = photo_cover['url']
    photo_show = Cloudinary::Uploader.upload("db/fixtures/images/artists/#{photo_title}-show.jpg", :use_filename => true, :folder => "thatsmyrock/albums")
    album.remote_photo_show_url = photo_show['url']
  rescue
    puts "No album photo for #{row[:name]}"
  end
    album.save!
end

puts "Creating tracklists..."
filepath = Rails.root.join('db/fixtures/csv/tracklists.csv')

CSV.foreach(filepath, csv_options) do |row|
  album = Album.find_by(name: row[:album])

  Track.create!(
    album: album,
    tracklist_order: row[:tracklist_order],
    name: row[:name],
    duration: row[:duration],
    )
end

puts "Finished!"
