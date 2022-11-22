class Api::V1::TimelinesController < ApplicationController
  include Pagenation

  def show
    user = User.find_by(email: 'hm385.chejptks@gmail.com')

    array = user.following_ids.push(user.id)
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
