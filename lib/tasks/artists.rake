namespace :artists do
  desc "Generate photo name for each artist"
  task generate_photo_names: :environment do
    filepath = Rails.root.join("tmp/artist_photo_names.txt")

    File.open(filepath, "wb") do |file|
      Artist.all.each do |artist|
        photo_file_name = "#{I18n.transliterate(artist.name.gsub('&', 'and').parameterize)}.jpg"
        file.write("#{photo_file_name}\n")
      end
    end

    puts "Finished! File saved in: #{filepath}"
  end
end
