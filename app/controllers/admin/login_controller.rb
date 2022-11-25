class Admin::LoginController < Admin::ApplicationController
  before_action :authenticated_user!, only: %i[destroy]

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/admin'
    else
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
