class ProfilesController < ApplicationController

  def show
    @user_albums = current_user.user_albums
    # authorize :profile, :show?
    @avatar_user = current_user.photo
  end

end
