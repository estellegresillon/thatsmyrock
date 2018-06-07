class UserAlbumsController < ApplicationController
  before_action :set_user_album, only: [:show, :update, :destroy]

  def create
    @album = Album.find(params[:album_id])

    # @user_album = UserAlbum.new(user_album_params)

    @user_album = UserAlbum.find_or_initialize_by(user_id: current_user.id, album_id: @album.id)
    @user_album.assign_attributes(user_album_params)

    # @user_album.user = current_user
    # @user_album.album = @album
    @status = @user_album.status

    if @user_album.save!
      respond_to do |format|
        format.html { redirect_to albums_path }
        format.js  { render 'albums/update_index.js.erb' }
      end
    else
      respond_to do |format|
        format.html { render 'albums/index' }
        format.js  # <-- idem
      end
    end
  end


  def update
    #@user_album.user = current_user
    @user_album = UserAlbum.find(params[:id])
    @user_album.update(user_album_params)
    if @user_album.save
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.js  do
          if params[:user_album][:status]
            render 'user_albums/update.js.erb'
          else
            render 'user_albums/update_format.js.erb'
          end
        end
      end
    end
  end

  def destroy
    @user_album = UserAlbum.find(params[:id])
    @album = @user_album.album
    @user_album.destroy
    if @user_album.destroy
      respond_to do |format|
        format.html { redirect_to albums_path }
        format.js  { render 'albums/update_index.js.erb' }
      end
    else
      respond_to do |format|
        format.html { render 'albums/index' }
        format.js  # <-- idem
      end
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
