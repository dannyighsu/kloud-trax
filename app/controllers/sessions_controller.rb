class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if user == nil
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to '/signup'
    else
      session[:user_id] = user.id
      redirect_to '/player'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
