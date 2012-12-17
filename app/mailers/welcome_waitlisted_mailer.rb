class WelcomeWaitlistedMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Welcome Waitlisted Mail'

  default :from => "chris@mallowapp.com"
  default :fromname => "Mallow"

  helper ApplicationHelper

  # send a waitlisted user a welcome mail
  def welcome_waitlisted_mail(user)
    @user = user
    mail( :to => user.email,
    :subject => "Thanks for your interest in Mallow" )
  end
end
