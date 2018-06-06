require 'csv'

# Parsing options
csv_options = {
  col_sep: ';',
  quote_char: '"',
  headers: :first_row,
  header_converters: :symbol
}

puts "NOT cleaning database !!!"

puts "Creating or updating artists..."
filepath = Rails.root.join('db/fixtures/csv/artists.csv')

CSV.foreach(filepath, csv_options) do |row|
  normalized_name = I18n.transliterate(row[:name].gsub('&', 'and').parameterize)

  # find or initialize...
  artist = Artist.find_or_initialize_by(normalized_name: normalized_name)

  # update attributes
  artist.assign_attributes(
    name: row[:name],
    country: row[:country],
    facebook_url: row[:facebook_url],
    instagram_url: row[:instagram_url],
    twitter_url: row[:twitter_url],
    website_url: row[:website_url],
    wiki_url: row[:wiki_url],
    bio: row[:bio]
  )

  filepath = Rails.root.join("db/fixtures/images/artists/#{artist.normalized_name}.jpg")

  if artist.photo.blank? && File.exist?(filepath)
    # First, we upload the photo on cloudinary with options to keep filename and have specific folder
    photo = Cloudinary::Uploader.upload(filepath, use_filename: true, folder: "thatsmyrock/artists")

    # Then, we use the public_id that was returned in photo variable
    # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
    artist[:photo] = "image/upload/#{photo['public_id']}"
  end

  artist.save!
end

puts "Creating or updating albums..."
filepath = Rails.root.join('db/fixtures/csv/albums.csv')

CSV.foreach(filepath, csv_options) do |row|
  # 1) Trouver l'artiste correspondatn au nom d'artiste dans le csv
  # puts row[:artist]
  artist = Artist.find_by(name: row[:artist])

  # REFERENCE: album-name-artist-name
  normalized_name = "#{I18n.transliterate(row[:name].gsub('&', 'and').parameterize)}-#{artist.normalized_name}"

  # 2) Trouver ou créer un album avec l'artiste_id correspondant
  album = artist.albums.find_or_initialize_by(normalized_name: normalized_name)

  # update attributes
  album.assign_attributes(
    artist: artist,
    rank: row[:rank],
    name: row[:name],
    year: row[:year],
    decade: row[:decade],
    music_style: row[:music_style],
    wiki_url: row[:wiki_url],
    description: row[:description],
    deezer_album_id: row[:deezer_album_id]
  )

  filepath_cover = Rails.root.join("db/fixtures/images/albums/#{album.normalized_name}.jpg")
  filepath_show  = Rails.root.join("db/fixtures/images/albums/#{album.normalized_name}-show.jpg")

  if album.photo_cover.blank? && File.exist?(filepath_cover)
    # First, we upload the photo on cloudinary with options to keep filename and have specific folder
    photo_cover = Cloudinary::Uploader.upload(filepath_cover, use_filename: true, folder: "thatsmyrock/albums")

    # Then, we use the public_id that was returned in photo variable
    # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
    album[:photo_cover] = "image/upload/#{photo_cover['public_id']}"
  end

  if album.photo_show.blank? && File.exist?(filepath_show)
    photo_show = Cloudinary::Uploader.upload(filepath_show, use_filename: true, folder: "thatsmyrock/albums")
    album[:photo_show] = "image/upload/#{photo_show['public_id']}"
  end

  album.save!
end

# # NOT USED AT ALL
# puts "Creating tracklists..."
# filepath = Rails.root.join('db/fixtures/csv/tracklists.csv')

# CSV.foreach(filepath, csv_options) do |row|
#   album = Album.find_by(name: row[:album])

#   Track.create!(
#     album: album,
#     tracklist_order: row[:tracklist_order],
#     name: row[:name],
#     duration: row[:duration],
#     )
# end

puts "Finished!"
