class UserAlbumsController < ApplicationController
  before_action :set_user_album, only: [:show, :update, :destroy]

  def create
    @album = Album.find(params[:album_id])
    @user_album = UserAlbum.new(user_album_params)
    @user_album.user = current_user
    @user_album.album = @album
    if @user_album.save
      if @user_album.status == "wishlist"
        redirect_to profile_path(tab: "wishlist")
      elsif @user_album.status == "collected"
        redirect_to profile_path(tab: "collected")
      end
    else
      render "/profile"
    end
  end


  def update
    #@user_album.user = current_user
    @user_album.update(user_album_params)
    if @user_album.status == "wishlist"
      redirect_to profile_path(tab: "wishlist")
    elsif @user_album.status == "collected"
      redirect_to profile_path(tab: "collected")
    end
  end

  def destroy
    @user_album = UserAlbum.find(params[:id])
    if @user_album.destroy
      if @user_album.status == "wishlist"
        redirect_to profile_path(tab: "wishlist")
      elsif @user_album.status == "collected"
        redirect_to profile_path(tab: "collected")
      end
    else
      redirect_to "/profile"
    end
  end


  private

  def set_user_album
    @user_album = UserAlbum.find(params[:id])
    #authorize @user_album
   end

  def user_album_params
    params.require(:user_album).permit(:status, :album_id, :artist_id, :vinyl, :cd, :digital)
  end


end
