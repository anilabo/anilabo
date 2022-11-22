class Api::V1::TimelinesController < ApplicationController
  def show
    user = User.find_by(email: 'hm385.chejptks@gmail.com')

    array = user.following_ids.push(user.id)
    notifications = Notification
                    .includes(%i[watch_log anime operative_user passive_user])
                    .where(operative_user_id: array)
                    .order(created_at: :desc)

    render json: notifications, status: :ok
  end
end
