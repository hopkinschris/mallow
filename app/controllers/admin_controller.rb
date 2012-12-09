class AdminController < ApplicationController
  def show
    unless admin_user?
      flash[:error]= raw(t 'alert.user.auth')
      redirect_to root_url
    end
  end

  def activate
    user = User.find(params[:user])
    user.waitlist = false
    user.save
    WelcomeMailer.welcome_mail(user).deliver
    flash[:success]= raw(t 'alert.admin.success')
    redirect_to admin_url
  end
end
