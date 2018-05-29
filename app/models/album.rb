class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :artist
  has_many :user_albums, dependent: :destroy

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Album.next(self.id).first
  end

  def previous
    Album.previous(self.id).first
  end

end
