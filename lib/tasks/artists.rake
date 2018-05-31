
namespace :artists do
  desc "Generate photo name for each artist"
  task generate_photo_names: :environment do
    filepath = Rails.root.join("tmp/artist_photo_names.txt")

    File.open(filepath, "wb") do |file|
      Artist.all.each do |artist|
        file.write("#{artist.normalized_name}.jpg\n")
      end
    end

    puts "Finished! File saved in: #{filepath}"
  end

  # script to import
  desc "Import artist photos"
  task import_photos: :environment do
    require 'open-uri'
    require 'zip'

    # Download archive file
    puts "Downloading the archive..."
    url = "http://thatsmyrock.com/artists.zip" # zip containing all artists JPGs

    archive_file = Tempfile.new(["artists", ".zip"])
    File.open(archive_file, 'wb') { |file| file.write(open(url).read) }

    # Unzip archive
    puts "Unzip archive..."
    Zip::File.open(archive_file.path) do |zip_file|
      entries = zip_file.glob("_cloudinary/*.jpg")

      puts "Importing photos..."
      entries.each do |entry|
        filename = File.basename(entry.name)
        normalized_name = File.basename(filename, ".jpg")
        artist = Artist.find_by(normalized_name: normalized_name)

        if artist
          # Create temporary photo file
          photo_file = Tempfile.new([normalized_name, ".jpg"])
          File.open(photo_file.path, 'wb') { |file| file.write(entry.get_input_stream.read) }

          # First, we upload the photo on cloudinary with options to keep filename and have specific folder
          photo = Cloudinary::Uploader.upload(photo_file.path, use_filename: true, folder: "thatsmyrock/artists")

          # Then, we use the public_id that was returned in photo variable
          # We have to set directly the attribute with [:photo] otherwise it uses the uploader and uploads a second time
          artist[:photo] = "image/upload/#{photo['public_id']}"
          artist.save
        else
          puts "Artist not found: #{artist.normalized_name}"
        end
      end
    end

    puts "Finished!"
  end
end
