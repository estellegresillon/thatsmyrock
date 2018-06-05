class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums
  mount_uploader :photo, PhotoUploader
  after_commit :remove_photo!, on: :destroy

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Artist.next(self.id).first
  end

  def previous
    Artist.previous(self.id).first
  end
end
