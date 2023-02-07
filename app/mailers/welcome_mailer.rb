class WelcomeMailer < ApplicationMailer
  default from: 'notifications@sampers.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Sampers Social Media.')
  end
end
