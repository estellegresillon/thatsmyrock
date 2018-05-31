namespace :albums do
  desc "Generate photo name for each album"
  task generate_photo_names: :environment do
    filepath = Rails.root.join("tmp/album_photo_names.txt")

    File.open(filepath, "wb") do |file|
      Album.all.each do |album|
        file.write("#{album.normalized_name}.jpg\n")
      end
    end

    puts "Finished! File saved in: #{filepath}"
  end

  # script to import
  desc "Import albums photos"
  task import_photos: :environment do
  end
end


# TO FINISH
