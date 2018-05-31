class AlbumsController < ApplicationController

  def index
    search_options = []
    if params[:artist].present?
      search_options << params[:artist]
    end
    if params[:decade].present?
      search_options << params[:decade]
    end
    if params[:year].present?
      search_options << params[:year]
    end
    if params[:name].present?
      search_options << params[:name]
    end
    if params[:music_style].present?
      search_options << params[:music_style]
    end
    if search_options.blank?
      @albums = Album.all
    else
      @albums = Album.search_albums(search_options).ordered_by_rank
    end
    respond_to do |format|
        format.html
        format.js
    end
  end

  def show
    @album = Album.find(params[:id])
    @user_album = UserAlbum.new
  end

end
