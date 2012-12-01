class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    if user.email.blank?
      redirect_to edit_user_path(user)
    else
      flash[:success]= raw(t 'alert.session.log_in')
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def new
    redirect_to '/auth/twitter'
  end

  def failure
    flash[:error]= raw(t 'alert.session.fail', :message => params[:message].humanize)
    redirect_to root_url
  end

end
