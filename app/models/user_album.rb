class UserAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album
  validates_uniqueness_of :user_id, :scope => [:album_id]

  #todo add validation unicity of album_id and user_id



  def rank
    album.rank
  end
end
