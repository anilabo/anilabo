class Api::V1::AnimesController < ApplicationController
  before_action :set_anime, only: %i[show]

  def index
    animes = Anime.all
    render json: animes
  end

  def show
    render json: @anime
  end

  private

    def set_anime
      @anime = Anime.find_by(params[:public_uid])
    end
end
