class FeedbackMailer < ActionMailer::Base
  include SendGrid

  sendgrid_category 'Feedback Mail'

  default :from => "feedback@mallowapp.com"
  default :fromname => "Mallow"
  default :to => "chris@mallowapp.com"

  # send mail with feedback
  def feedback_mail(feedback)
    @feedback = feedback
    mail( :subject => "Feedback submitted on #{Time.now.strftime("%b. %e")}" )
  end

  def task_mail(count)
    @count = count
    mail( :subject => "$rake get_unfollowers for #{Time.now.strftime("%b. %e")} complete")
  end
end
