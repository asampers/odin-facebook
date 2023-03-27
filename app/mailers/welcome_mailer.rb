class WelcomeMailer < ApplicationMailer
  default from: 'afriendbook@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'https://friendbook.fly.dev/'
    mail(to: @user.email, subject: 'Welcome to Friend Book.')
  end
end
