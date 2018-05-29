require 'csv'

csv_options = {
  col_sep: ',',
  quote_char: '"',
  headers: :first_row
}

filepath    = 'artists.csv'
CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ['name',
           'country',
           'facebook_url',
           'instagram_url',
           'twitter_url',
           'website_url',
           'wiki_url',
           'bio',
           'photo'
   ]


csv_options = {
  col_sep: ',',
  quote_char: '"',
  headers: :first_row
}

filepath    = 'albums.csv'
CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ['artist', 'rank', 'name', 'year', 'music_style', 'wiki_url', 'photo_cover', 'description']

csv_options = {
  col_sep: ',',
  quote_char: '"',
  headers: :first_row
}

filepath    = 'tracklists.csv'
CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ['album', 'tracklist_order', 'name', 'duration']
end



# artists
# name;country;facebook_url;instagram_url;twitter_url;website_url;wiki_url;bio;photo
#     t.string "name"
#     t.string "facebook_url"
#     t.string "wiki_url"
#     t.text "bio"
#     t.string "instagram_url"
#     t.string "twitter_url"
#     t.string "photo"
#     t.string "country"

# albums
# artist;rank;name;year;music_style;wiki_url;photo_cover;description
#     t.string "name"
#     t.text "description"
#     t.string "music_style"
#     t.integer "year"
#     t.integer "rank"
#     t.string "wiki_url"
#     t.string "photo_cover"
#     t.string "photo_show"

# trakclists
# album;tracklist_order;name;duration
#     t.string "name"
#     t.bigint "album_id"
#     t.integer "duration"
