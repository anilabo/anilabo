class Api::V1::UserSimpleInfoController < Api::ApplicationController
  before_action :set_user

  def show
    render json: @user, serializer: UserShortInfoSerializer, status: :ok
  end

  private

    def set_user
      @user = User.find_by(uid: params[:user_uid])
      response_not_found(:user) if @user.blank?
    end
end
