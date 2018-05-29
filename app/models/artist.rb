class Artist < ApplicationRecord
  include PgSearch
  multisearchable :against => :name

  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  mount_uploader :photo, PhotoUploader
end
