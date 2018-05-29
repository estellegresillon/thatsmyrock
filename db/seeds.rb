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
  Artist.create!(
    name: row[:name],
    country: row[:country],
    facebook_url: row[:facebook_url],
    instagram_url: row[:instagram_url],
    twitter_url: row[:twitter_url],
    website_url: row[:website_url],
    wiki_url: row[:wiki_url],
    bio: row[:bio],
    # photo: row[:photo]
  )
end

puts "Creating albums..."
filepath = Rails.root.join('db/fixtures/csv/albums.csv')

CSV.foreach(filepath, csv_options) do |row|
  # 1) Trouver l'artiste correspondatn au nom d'artiste dans le csv
  artist = Artist.find_by(name: row[:artist])
  # 2) Créer un album avec l'artiste_id correspondant
  Album.create!(
    artist: artist,
    rank: row[:rank],
    name: row[:name],
    year: row[:year],
    music_style: row[:music_style],
    wiki_url: row[:wiki_url],
    description: row[:description]
    # photo_cover: row[:photo_cover'],
    # photo_cover: row[:photo_show'],
  )
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
