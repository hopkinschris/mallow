class AdminController < ApplicationController
  def show
    unless admin_user?
      flash[:error]= raw(t 'alert.user.auth')
      redirect_to root_url
    end
  end

  def activate
    user = User.find(params[:user])
    if user.email?
      user.waitlist = false
      user.save
      WelcomeMailer.welcome_mail(user).deliver
      flash[:success]= raw(t 'alert.admin.success_activated')
      redirect_to admin_url
    else
      flash[:error]= raw(t 'alert.admin.error')
      redirect_to admin_url
    end
  end

  def deactivate
    user = User.find(params[:user])
    user.waitlist = true
    user.save
    flash[:success]= raw(t 'alert.admin.success_deactivated')
    redirect_to admin_url
  end
end
