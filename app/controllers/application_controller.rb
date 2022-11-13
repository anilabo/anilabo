class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_firebase_token

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  def token_from_request_headers
    request.headers['Authorization']&.split&.last
  end

  def token
    params[:token] || token_from_request_headers
  end

  def payload
    @payload ||= FirebaseIdToken::Signature.verify token
  end

  def logged_in_user
    if Rails.env.test?
      @logged_in_user ||= User.first
    else
      return if payload.nil?

      @logged_in_user ||= User.find_by(uid: payload['sub'])
    end
  end

  def logged_in_user!
    raise 'Authenticated Error' if logged_in_user.nil?
  end

  private

    def set_firebase_token
      FirebaseIdToken::Certificates.request unless FirebaseIdToken::Certificates.present?
    end
end
