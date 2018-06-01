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
      @albums = Album.all.paginate(page: params[:page])
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
