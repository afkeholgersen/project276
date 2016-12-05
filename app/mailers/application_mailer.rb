class ApplicationMailer < ActionMailer::Base
  default from: 'foodnatic@foodnatic.heroku.com'
  layout 'mailer'
end
