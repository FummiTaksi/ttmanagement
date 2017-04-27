class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_player

  def current_player
    return nil if session[:player_id].nil?
    Player.find(session[:player_id])
  end

  end
