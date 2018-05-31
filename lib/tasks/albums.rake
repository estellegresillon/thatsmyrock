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
    require 'open-uri'
    require 'zip'

    #Download archive file
    puts "Downloading the archive..."
    url = "http://thatsmyrock.com/albums.zip"

    archive_file = Tempfile.new(["albums", ".zip"])
    File.open(archive_file, 'wb') { |file| file.write(open(url).read) }

    # Unzip archive
    puts "Unzip archive..."
    Zip::File.open(archive_file.path) do |zip_file|
      entries = zip_file.glob("_cloudinary/*.jpg")

      puts "Importing photos..."
      entries.each do |entry|
        filename = File.basename(entry.name)
        normalized_name = File.basename(filename, ".jpg")
        album = Album.find_by(normalized_name: normalized_name)

        if album
          # Create temporary photo file
          photo_file = Tempfile.new([normalized_name, ".jpg"])
          File.open(photo_file.path, 'wb') { |file| file.write(entry.get_input_stream.read) }

          # First, we upload the photo on cloudinary with options to keep filename and have specific folder
          photo = Cloudinary::Uploader.upload(photo_file.path, use_filename: true, folder: "thatsmyrock/albums")

          # Then, we use the public_id that was returned in photo variable
          # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
          album[:photo_cover] = "image/upload/#{photo['public_id']}"
          album.save

        else
          puts "Arlbum not found: #{album.normalized_name}"
        end
      end
    end

    puts "Finished!"
  end
end
