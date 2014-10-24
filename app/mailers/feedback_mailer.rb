class FeedbackMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Feedback Mail'

  default :from => ENV['ADMIN_EMAIL']
  default :fromname => "Mallow"
  default :to => ENV['ADMIN_EMAIL']

  # send mail with feedback
  def feedback_mail(feedback)
    @feedback = feedback
    mail( :subject => "Feedback submitted on #{Time.now.strftime("%b. %e")}" )
  end
end
