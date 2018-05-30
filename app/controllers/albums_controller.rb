class AlbumsController < ApplicationController

  def index
    search_options = []
    if params[:artist].present?
      search_options << params[:artist]
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
    if params[:decenia].present?
      search_options << params[:decenia]
    end
    if search_options.blank?
      @albums = Album.all
    else
      @albums = Album.search_albums(search_options)
    end
  end

  def show
    @album = Album.find(params[:id])
    @user_album = UserAlbum.new
  end

end
