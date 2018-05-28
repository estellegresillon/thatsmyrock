class Album < ApplicationRecord
  has_many :tracks
  belongs_to :artist
  has_many :user_albums
end
