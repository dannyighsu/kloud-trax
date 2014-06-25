class UsersController < ApplicationController

  def create
    @user = current_user
  end

  def update
    @user = current_user
    @user.username = params[:user][:username]
    if User.find_by(username: @user.username)
      flash[:error] = "Username \"#{@user.username}\" already exists."
      redirect_to "/signup"
    elsif @user.username.length < 4
      flash[:error] = "Username must be at least 4 characters."
      redirect_to "/signup"
    else
      @user.save
      redirect_to "/player"
    end
  end

  def populate
    populateall
    redirect_to root_url
  end

end
