class Admin::LoginController < Admin::ApplicationController
  before_action :authenticated_user!, only: %i[destroy]

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id if user&.authenticate(params[:password])
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
