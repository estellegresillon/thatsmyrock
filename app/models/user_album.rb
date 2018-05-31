class UserAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album


  def rank
    album.rank
  end
end
