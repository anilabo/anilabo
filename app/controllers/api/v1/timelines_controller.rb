class Api::V1::TimelinesController < Api::ApplicationController
  include Pagenation

  before_action :authenticate_user

  def show
    array = current_user.following_ids.push(current_user.id)
    notifications = Notification
                    .includes(%i[watch_log anime operative_user passive_user])
                    .where(operative_user_id: array)
                    .order(created_at: :desc)
                    .page(params[:page])
                    .per(10)

    pagenation = pagenation(notifications)

    render json: notifications, meta: pagenation, status: :ok
  end
end
