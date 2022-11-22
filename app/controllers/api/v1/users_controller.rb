class Api::V1::UsersController < ApplicationController
  include Firebase::Auth::Authenticable
  skip_before_action :verify_authenticity_token

  before_action :set_user, only: %i[show]

  def show
    render json: @user, status: :ok
  end

  def create
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?
    return if User.find_by(uid: payload['sub'])

    user = User.create!(sign_up_params.merge(
                          uid: payload['sub'],
                          display_name: payload['name'],
                          photo_url: payload['picture']
                        ))
    render json: user, status: :ok
  end

  private

    def set_user
      @user = User.preload(
        active_notifications: %i[watch_log anime operative_user passive_user],
        passive_notifications: %i[watch_log anime operative_user passive_user]
      ).find_by(uid: params[:uid])
      response_not_found(:user) if @user.blank?
    end

    def sign_up_params
      params.require(:user).permit(:email)
    end
end
