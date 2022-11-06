class Api::V1::UsersController < ApplicationController
  include Firebase::Auth::Authenticable
  skip_before_action :verify_authenticity_token

  def show
    user = User.find_by(uid: params[:uid])
    render json: user, status: :ok
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
end
