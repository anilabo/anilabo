class Api::V1::NotificationsController < ApplicationController
  before_action :set_user

  def show
    notifications = Notification.where(operative_user_id: @user.id).or(Notification.where(passive_user_id: @user.id))
    render json: notifications, status: :ok
  end

  private

    def set_user
      @user = User.find_by(uid: params[:user_uid])
    end
end
