class UsersController < ApplicationController
  def show
    @artists = current_user.artists
  end
end
