class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_player
  helper_method :clubowner_signed_in
  before_action :require_admin

  def current_player
    return nil if session[:player_id].nil?
    Player.find(session[:player_id])
  end

  def clubowner_signed_in
    current_player and current_player.clubowner
  end


  private

  def require_admin
    if !current_player or !current_player.admin
      flash[:error] = "You must be admin to access this section"
      redirect_to root_path
    end
  end



  end
