class Admin::ApplicationController < ActionController::Base
  helper_method %i[current_user authenticated_user!]

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authenticated_user!
      errors.add('Require authenticated.') if current_user.nil?
    end
end
