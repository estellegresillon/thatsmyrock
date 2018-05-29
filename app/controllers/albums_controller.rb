class AlbumsController < ApplicationController

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @user_album = UserAlbum.new
  end

end
