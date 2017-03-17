class SessionsController < ApplicationController

  def new

  end

  def create
    player = Player.find_by username: params[:username]
    if player and player.authenticate(params[:password])
    session[:player_id] = player.id if not player.nil?
    redirect_to player, notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
      end
  end

  def destroy
    session[:player_id]  = nil
    redirect_to :root
  end
end