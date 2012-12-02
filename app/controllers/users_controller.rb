class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?

  def show
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]= raw(t 'alert.user.success')
      redirect_to root_url
    else
      render :edit
    end
  end

end
