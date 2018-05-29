class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :artist
  has_many :user_albums, dependent: :destroy
end
