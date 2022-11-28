class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL', nil)
  layout 'mailer'
end
