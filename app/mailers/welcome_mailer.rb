class WelcomeMailer < ApplicationMailer
  default from: 'afriendbook@friendly.com'

  def welcome_email(user)
    @user = user
    @url = 'https://friendbook.fly.dev/'
    mail(to: @user.email, subject: 'Welcome to Sampers Social Media.')
  end
end
