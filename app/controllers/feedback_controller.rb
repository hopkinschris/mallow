class FeedbackController < ApplicationController

  skip_before_filter :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    if params[:feedback]
      @feedback = Feedback.new(params[:feedback])
      if @feedback && @feedback.valid?
        FeedbackMailer.feedback_mail(@feedback).deliver
        redirect_to root_url
        flash[:success]= raw(t 'alert.feedback.success')
      else
        flash[:error]= raw(t 'alert.feedback.fail', :errors => flash_errors(@feedback))
        render :new
      end
    end
  end
end
