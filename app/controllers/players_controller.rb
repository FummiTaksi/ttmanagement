class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [:show, :index, :new, :edit, :destroy, :update, :create]


  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end



  def toggle_admin

    if current_player and current_player.admin
      player = Player.find(params[:id])
      if player.admin
        player.admin = false
      else
        player.admin = true
      end
      player.save
      new_status = player.clubowner ? "Admin" : "Not Admin"
      redirect_to :back, notice: "This users status changed to #{new_status}"
    end

  end




  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
    if !current_player or current_player != @player
      flash[:error] = "You are not allowed to edit this player!"
      redirect_to player_path(@player)
    end
  end



  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.admin = false
    @player.clubowner = false
    generate_username
    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    if @player.username == current_player.username
      if @player.clubowner  and !@player.club.nil?
        @player.club.destroy
      end
      matches = Match.all
      matches.each{|match| match.destroy if match.player1_id == @player.id or match.player2_id == @player.id}
      @player.destroy
      respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
    session[:player_id] = nil
    end

  end

  def toggle_clubowner

    player = Player.find(params[:id])
    if player.clubowner
      player.clubowner = false
    else
      player.clubowner = true
    end
    player.save
    new_status = player.clubowner ? "clubowner" : "not clubowner"
    redirect_to :back, notice: "This users status changed to #{new_status}"
  end

  def generate_username
    @player.username = "#{@player.firstname}#{@player.lastname}"
    withsamefirstname = Player.where firstname:@player.firstname
    withsamelastname = withsamefirstname.where lastname:@player.lastname
    if  not withsamelastname.empty?
      @player.username = "#{@player.firstname}#{@player.lastname}#{withsamelastname.size + 1}"
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:firstname, :lastname, :username, :birthday, :password, :password_confirmation)
    end
end
