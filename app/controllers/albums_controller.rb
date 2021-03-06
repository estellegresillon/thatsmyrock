class AlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
    @search = params[:search]

    if search_options.blank?
      @albums = Album.paginate(page: params[:page]).ordered_by_rank
    else
      @albums = Album.search_albums(search_options).paginate(page: params[:page]).ordered_by_rank
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @album = Album.find(params[:id])
    @user_album = UserAlbum.new
    @artist = @album.artist
    @albums = @artist.albums
    @random_album = Album.order("RANDOM()").first
  end
end
