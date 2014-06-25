class PagesController < ApplicationController

  def index
    if current_user
      redirect_to '/player'
    end
  end

  def about
  end

  def help
  end

end
