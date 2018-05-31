class ProfilesController < ApplicationController

  def index
    @tab = params["tab"]
    @user_albums = UserAlbum.where(status: "collected").reorder(id: :asc)
  end

end
