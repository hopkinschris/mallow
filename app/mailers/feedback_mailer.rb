class FeedbackMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Feedback Mail'

  default :from => "feedback@mallowapp.com"
  default :to => "chris@mallowapp.com"

  # send mail with feedback
  def feedback_mail(feedback)
    @feedback = feedback
    mail( :subject => "Feedback submitted on #{Time.now.strftime("%b. %e")}" )
  end
end
