class WelcomeMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Welcome Mail'

  default :from => "chris@mallowapp.com"
  default :fromname => "Mallow"

  helper ApplicationHelper

  # send a user a welcome mail
  def welcome_mail(user)
    @user = user
    mail( :to => user.email,
    :subject => "Welcome to Mallow" )
  end
end
