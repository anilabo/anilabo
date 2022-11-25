class Api::V1::RelationshipsController < Api::ApplicationController
  before_action :authenticate_user
  before_action :set_target_user

  def create
    current_user.follow(@target_user.id)

    render json: current_user, status: :ok
  end

  def destroy
    current_user.unfollow(@target_user.id)
    render json: current_user, status: :ok
  end

  private

    def set_target_user
      @target_user = User.find_by!(uid: params[:user_uid])
    end
end
