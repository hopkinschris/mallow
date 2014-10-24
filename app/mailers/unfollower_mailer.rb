class UnfollowerMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Unfollower Mail'

  default :from => ENV['ADMIN_EMAIL']

  helper ApplicationHelper

  # send a user a list of their unfollowers
  def unfollowers_mail(user)
    @user = user
    mail( :to => user.email,
    :subject => "Here's your Twitter unfollowers for #{Time.now.strftime("%b. %e")}" )
  end
end
