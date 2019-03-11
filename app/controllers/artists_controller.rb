class ArtistsController < ApplicationController
  before_action :login_required, except: :index

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = current_user.artists.new(artist_params)

    if @artist.save
      redirect_to root_path, notice: "登録完了"
    else
      render :new
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist =  Artist.find(params[:id])

    if @artist.update(artist_params)
      redirect_to root_path, notice: "更新完了"
    else
      render :edit
    end
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy
    redirect_to user_path(current_user.id), notice: "削除しました"
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :furi_gana, :image, :place, :profile, :hp, :twitter, :youtube)
  end
end
