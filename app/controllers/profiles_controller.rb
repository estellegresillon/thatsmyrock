class ProfilesController < ApplicationController

  def index
    @tab = params["tab"]
    @user_album = UserAlbum.order(Album.arel_table['rank'].asc)

  end

end
