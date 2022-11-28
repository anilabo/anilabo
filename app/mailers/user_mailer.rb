class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = ENV.fetch('ANIMEDIA_URL', nil)
    mail(to: @user.email, subject: 'Welcome to animedia!')
  end
end
