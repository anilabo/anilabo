class Api::V1::NotificationsController < ApplicationController
  before_action :set_user

  def show
    notifications = @user.active_notifications
    render json: notifications, status: :ok
  end

  private

    def set_user
      @user = User.find_by(uid: params[:user_uid])
    end
end
