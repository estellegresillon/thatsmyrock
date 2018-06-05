class ProfilesController < ApplicationController
  def index
    @tab = params["tab"]
    @user_albums = current_user.user_albums
    search_options = [params[:name]] if params[:name].present?
    if search_options.present?
      @albums = current_user.albums.search_albums(search_options).ordered_by_rank
      @user_albums = current_user.user_albums.where(album_id: @albums.pluck(:id))
    end
    @my_collection = @user_albums.where(status: 'collected').sort_by { |ua| ua.album.rank }
    @my_wishlist = @user_albums.where(status: 'wishlist').sort_by { |ua| ua.album.rank }
    end
end



