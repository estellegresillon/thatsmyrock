class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :artist
  has_many :user_albums, dependent: :destroy
  mount_uploader :photo_cover, PhotoUploader
  mount_uploader :photo_show, PhotoUploader
end
