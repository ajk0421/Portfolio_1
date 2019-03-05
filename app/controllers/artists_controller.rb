class ArtistsController < ApplicationController

  def index
  end

  def new
    @artist = Artist.new
  end

  def create
    artist = Artist.new(artist_params)
    artist.save!
    redirect_to root_path, notice: "登録完了"
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :furi_gana, :image, :place, :profile, :hp, :twitter, :youtube)
  end
end
