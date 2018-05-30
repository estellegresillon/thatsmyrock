namespace :albums do
  desc "Generate photo name for each album"
  task generate_photo_names: :environment do
    filepath = Rails.root.join("tmp/album_photo_names.txt")

    File.open(filepath, "wb") do |file|
      Album.all.each do |album|
        photo_file_name = "#{I18n.transliterate(album.name.gsub('&', 'and').parameterize)}-#{I18n.transliterate(album.artist.name.gsub('&', 'and').parameterize)}.jpg"
        file.write("#{photo_file_name}\n")
      end
    end

    puts "Finished! File saved in: #{filepath}"
  end
end
