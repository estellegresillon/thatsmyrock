class ProfilesController < ApplicationController

  def index
    @tab = params["tab"]
  end

end
