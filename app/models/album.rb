class Album < ApplicationRecord
  include PgSearch
  multisearchable :against => [:name, :year, :music_style]

  has_many :tracks, dependent: :destroy
  belongs_to :artist
  has_many :user_albums, dependent: :destroy
end
