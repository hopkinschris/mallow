class UnfollowerMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Unfollower Mail'

  default :from => "chris@mallowapp.com"

  # send a user a list of their unfollowers
  def new_mail(user)
    @user = user
    mail( :to => user.email,
    :subject => "Mallow" )
  end
end
