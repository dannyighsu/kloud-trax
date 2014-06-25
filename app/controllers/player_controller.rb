class PlayerController < ApplicationController

  def player
    @user = current_user
  end

  def to_preferences
    respond_to do |format|
      format.js {}
    end
  end

end
