class SettingsController < ApplicationController

  def show
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end
end
