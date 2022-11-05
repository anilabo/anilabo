class Api::V1::UsersController < ApplicationController
  include Firebase::Auth::Authenticable
  skip_before_action :verify_authenticity_token

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

    def sign_up_params
      params.require(:user).permit(:email)
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
end
