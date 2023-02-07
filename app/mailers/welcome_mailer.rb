class WelcomeMailer < ApplicationMailer
  default from: 'notifications@sampers.com'

  def welcome_email
    @user = params[:user]
    @url = root_url
    mail(to: @user.email, subject: 'Welcome to Sampers Social Media.')
  end
end
