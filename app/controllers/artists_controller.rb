class ArtistsController < ApplicationController
  before_action :login_required, except: :index

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to root_path, notice: "登録完了"
    else
      render :new
    end
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
