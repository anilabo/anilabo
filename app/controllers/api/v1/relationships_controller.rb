class Api::V1::RelationshipsController < ApplicationController
  before_action :logged_in_user!
  before_action :set_target_user

  def create
    logged_in_user.follow(@target_user.id)

    render json: logged_in_user, status: :ok
  end

  def destroy
    logged_in_user.unfollow(@target_user.id)
    render json: logged_in_user, status: :ok
  end

  private

    def set_target_user
      @target_user = User.find_by!(uid: params[:user_uid])
    end
end
