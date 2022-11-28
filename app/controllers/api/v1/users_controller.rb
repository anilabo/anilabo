class Api::V1::UsersController < Api::ApplicationController
  before_action :set_user, only: %i[show]
  before_action :set_user_params, only: %i[create]

  def show
    render json: @user, status: :ok
  end

  def create
    raise ArgumentError, 'BadRequest Parameter' if payload.blank?
    return if User.find_by(uid: payload['sub'])

    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_later
      render json: @user, status: :ok
    else
      render json: @user.errors.full_messages, status: :internal_server_error
    end
  end

  private

    def set_user
      @user = User.preload(
        active_notifications: %i[watch_log anime operative_user passive_user],
        passive_notifications: %i[watch_log anime operative_user passive_user]
      ).find_by(uid: params[:uid])
      response_not_found(:user) if @user.blank?
    end

    def token_from_request_headers
      request.headers['Authorization']&.split&.last
    end

    def token
      params[:token] || token_from_request_headers
    end

    def payload
      @payload ||= FirebaseIdToken::Signature.verify token
    end

    def set_user_params
      @user = User.new(
        uid: payload['sub'],
        display_name: payload['name'],
        photo_url: payload['picture'],
        email: payload['email']
      )
    end
end
