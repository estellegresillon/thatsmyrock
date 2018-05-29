class UserAlbumsController < ApplicationController
  before_action :set_user_album, only: [:show, :update, :destroy]

  def index
    @user_albums = UserAlbum.all
  end

  def show
    @user_album = UserAlbum.find(params[:id])
  end

  def create
    @user_album = UserAlbum.new(user_album_params)
    @user_album.save
  end


  def update
    #@user_album.user = current_user
    @user_album.update(user_album_params)
  end

  def destroy
    @user_album = UserAlbum.find(params[:id])
    @user_album.destroy

    redirect_to user_albums
  end


  private

  def set_user_album
    @user_album = UserAlbum.find(params[:id])
    #authorize @user_album
   end

  def user_album_params
    params.require(:user_album).permit(:status, :user_id, :album_id, :vinyl, :cd, :digital)
  end


end
