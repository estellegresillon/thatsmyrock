class AddTracklistOrderToTracks < ActiveRecord::Migration[5.2]
  def change
     add_column :tracks, :tracklist_order, :integer
  end
end
