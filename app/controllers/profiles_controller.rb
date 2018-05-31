class ProfilesController < ApplicationController

  def index
    @tab = params["tab"]
    @user_albums = UserAlbum.where(user: current_user)
    #@user_albums = @user_albums.sort_by{ |a| a.album.rank }
    @user_albums = @user_albums.sort_by(&:rank)
  end

end
