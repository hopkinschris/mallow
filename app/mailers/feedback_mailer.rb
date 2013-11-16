class FeedbackMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Feedback Mail'

  default :from => "mallowapp@hopkins.io"
  default :fromname => "Mallow"
  default :to => "mallowapp@hopkins.io"

  # send mail with feedback
  def feedback_mail(feedback)
    @feedback = feedback
    mail( :subject => "Feedback submitted on #{Time.now.strftime("%b. %e")}" )
  end
end
