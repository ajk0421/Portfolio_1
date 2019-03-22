class ArtistsController < ApplicationController
  before_action :login_required, except: [:index, :show]

  FURI_GANA = [/^[ア-オ]+/,/^[カ-コ]+/,/^[サ-ソ]+/,/^[タ-ト]+/,/^[ナ-ノ]+/,/^[ハ-ホ]+/,
              /^[マ-モ]+/,/^[ヤ-ヨ]+/,/^[ラ-ロ]+/,/^[ワ-ヲ]+/,/^[ン]+/]

  def index
    @artists = Artist.all
  end

  def gozyu_on
    @name = params[:name]
    id = params[:id].to_i
    @gozyu_on_artists = Artist.gozyu_on(FURI_GANA[id])
  end

  def new
    @artist = Artist.new
  end

  def confirm_new
    @artist = current_user.artists.new(artist_params)
    render :new unless @artist.valid?
  end

  def create
    @artist = current_user.artists.new(artist_params)
    @artist.image.retrieve_from_cache! params[:cache][:image]

    if params[:back].present?
      render :new
      return
    end

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
    params.require(:artist).permit(:name, :furi_gana, :image, :image_cache, :place, :profile, :hp, :twitter, :youtube)
  end
end