class Api::V1::AnimesController < ApplicationController
  before_action :set_anime, only: %i[show]

  def index
    @q = Anime.ransack(params[:q])
    animes = @q.result(distinct: true)
    render json: animes
  end

  def show
    render json: @anime
  end

  private

    def set_anime
      @anime = Anime.find_by(public_uid: params[:public_uid])
    end
end
