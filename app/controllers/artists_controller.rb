class ArtistsController < ApplicationController
  before_action :login_required, except: [:index, :show, :gozyu_on]
  before_action :set_artist, only: [:show, :edit, :destroy]

  FURI_GANA = [/^[ア-オ]+/,/^[カ-コ]+/,/^[サ-ソ]+/,/^[タ-ト]+/,/^[ナ-ノ]+/,/^[ハ-ホ]+/,
              /^[マ-モ]+/,/^[ヤ-ヨ]+/,/^[ラ-ロ]+/,/^[ワ-ン]+/]

  PER = 20

  def index
    @artists = Artist.all.order(created_at: :desc).page(params[:page]).per(PER)
  end

  def gozyu_on
    @name = params[:name]
    id = params[:id].to_i
    gozyu_on_artists = Artist.gozyu_on(FURI_GANA[id])

    @gozyu_on_artists = Kaminari.paginate_array(gozyu_on_artists).page(params[:page]).per(PER)
  end

  def new
    @artist = Artist.new
  end

  def confirm_new
    @artist = current_user.artists.new(artist_params)

    if !@artist.image.present?
      @artist.image.retrieve_from_cache! @artist.image_cache
    end

    @artist.image_cache = @artist.image.cache_name

    render :new unless @artist.valid?
  end

  def create
    @artist = current_user.artists.new(artist_params)
    @artist.image.retrieve_from_cache! @artist.image_cache

    if params[:back].present?
      render :new
      return
    end

    if @artist.save
      redirect_to user_path(current_user.id), notice: "登録完了"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def confirm_edit
    @artist = current_user.artists.find(params[:id])
    @artist.assign_attributes(artist_params)

    render :edit unless @artist.valid?
  end

  def update
    @artist =  current_user.artists.find(params[:id])
    @artist.image.retrieve_from_cache! params[:cache][:image] if params[:cache][:image].present?

    if params[:back].present?
      render :edit
      return
    end

    if @artist.update(artist_params)
      redirect_to artist_path, notice: "更新完了"
    else
      render :edit
    end
  end

  def destroy
    @artist.destroy
    redirect_to user_path(current_user.id), notice: "削除しました"
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :furi_gana, :image, :image_cache, :place, :profile, :hp, :twitter, :youtube)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
