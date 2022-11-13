class Api::V1::WatchLogsController < ApplicationController
  before_action :logged_in_user!
  before_action :set_anime

  def create
    watch_log = logged_in_user.user_animes.find_or_initialize_by(anime_id: @anime.id)

    if watch_log.update(watch_log_params)
      render json: @anime, serializer: AnimeDetailSerializer, status: :ok
    else
      render json: watch_log.errors.full_messages # ここ動くか確認する。
    end
  end

  def destroy
    watch_log = logged_in_user.user_animes.find_by!(anime_id: @anime.id)

    if watch_log.destroy
      render json: @anime, serializer: AnimeDetailSerializer, status: :ok
    else
      render json: watch_log.errors.full_messages
    end
  end

  private

    def set_anime
      @anime = Anime.find_by!(public_uid: params[:anime_public_uid])
    end

    def watch_log_params
      params.require(:watch_log).permit(:progress, :opinion, :finished_at)
    end
end
