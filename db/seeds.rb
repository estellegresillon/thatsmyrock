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
  )

  # photo_title = "#{row[:name].downcase.gsub(' ', '-')}"
  photo_title = I18n.transliterate(row[:name].gsub('&', 'and').parameterize)
  filepath    = Rails.root.join("db/fixtures/images/artists/#{photo_title}.jpg")

  if File.exist?(filepath)
    # First, we upload the photo on cloudinary with options to keep filename and have specific folder
    photo = Cloudinary::Uploader.upload(filepath, use_filename: true, folder: "thatsmyrock/artists")

    # Then, we use the public_id that was returned in photo variable
    # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
    artist[:photo] = "image/upload/#{photo['public_id']}"
  end

  artist.save!
end




puts "Creating albums..."
filepath = Rails.root.join('db/fixtures/csv/albums.csv')

CSV.foreach(filepath, csv_options) do |row|
  # REFERENCE: album-name-artist-name.jpg

  # 1) Trouver l'artiste correspondatn au nom d'artiste dans le csv
  # puts row[:artist]
  artist = Artist.find_by(name: row[:artist])

  # 2) Créer un album avec l'artiste_id correspondant
  album = Album.new(
    artist: artist,
    rank: row[:rank],
    name: row[:name],
    year: row[:year],
    decade: row[:decade],
    music_style: row[:music_style],
    wiki_url: row[:wiki_url],
    description: row[:description]
  )

  # photo_title = "#{row[:name]}-#{row[:artist]}".downcase.gsub(' ', '-')
  photo_title = "#{I18n.transliterate(row[:name].gsub('&', 'and').parameterize)}-#{I18n.transliterate(row[:artist].gsub('&', 'and').parameterize)}"

  filepath_cover = Rails.root.join("db/fixtures/images/albums/#{photo_title}.jpg")
  filepath_show = Rails.root.join("db/fixtures/images/albums/#{photo_title}-show.jpg")

  if File.exist?(filepath_cover)
    # First, we upload the photo on cloudinary with options to keep filename and have specific folder
    photo_cover = Cloudinary::Uploader.upload(filepath_cover, use_filename: true, folder: "thatsmyrock/albums")

    # Then, we use the public_id that was returned in photo variable
    # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
    album[:photo_cover] = "image/upload/#{photo_cover['public_id']}"
  end

  if File.exist?(filepath_show)
    photo_show = Cloudinary::Uploader.upload(filepath_show, use_filename: true, folder: "thatsmyrock/albums")
    album[:photo_show] = "image/upload/#{photo_show['public_id']}"
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
