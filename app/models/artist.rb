class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  mount_uploader :photo, PhotoUploader
  after_commit :remove_photo!, on: :destroy
end
