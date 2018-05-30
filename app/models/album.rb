class Album < ApplicationRecord

  include PgSearch
  pg_search_scope :search_albums,
  against: [ :name, :year, :music_style, :decade ],
  associated_against: {
    artist: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
    }


  has_many :tracks, dependent: :destroy
  belongs_to :artist
  has_many :user_albums, dependent: :destroy

  mount_uploader :photo_cover, PhotoUploader
  mount_uploader :photo_show, PhotoUploader

  after_commit :remove_photo_cover!, on: :destroy
  after_commit :remove_photo_show!, on: :destroy

  scope :ordered_by_rank, -> { reorder(rank: :asc) }
  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Album.next(self.id).first
  end

  def previous
    Album.previous(self.id).first
  end

end
