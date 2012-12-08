class SettingsController < ApplicationController

  def show
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      flash[:error]= raw(t 'alert.user.auth')
      redirect_to root_url
    end
  end
end
