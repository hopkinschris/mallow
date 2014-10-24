class WelcomeMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Welcome Mail'

  default :from => ENV['ADMIN_EMAIL']
  default :fromname => "Mallow"

  helper ApplicationHelper

  # send a user a welcome mail
  def welcome_mail(user)
    @user = user
    mail( :to => user.email,
    :subject => "Welcome to Mallow" )
  end
end
