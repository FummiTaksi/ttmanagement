class ClubsController < ApplicationController

  before_action :set_club, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [:show, :index, :edit, :new, :update, :create, :destroy]

  # GET /clubs
  # GET /clubs.json
  def index
    @clubs = Club.all
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    if !@club.players.include?(current_player)
      @membership = Membership.new
      @membership.club_id = @club_id
    else  # jos olen jäsen

      @membership =current_player.membership

    end

  end

  # GET /clubs/new
  def new
    if  !clubowner_signed_in or !current_player.club_id.nil?
      flash[:error] = "You are not allowed to create a club!"
      redirect_to clubs_path
    else
      @club = Club.new
      @players = Player.all
    end

  end

  # GET /clubs/1/edit
  def edit
    if !clubowner_signed_in or !current_player or current_player.club_id != @club.id
      flash[:error] = "You are not allowed to edit this club!"
      redirect_to club_path(@club)
    end
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(club_params)
    @club.players << current_player
    @club.player_id = current_player.id



    respond_to do |format|
      if @club.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render :show, status: :created, location: @club }
      else
        format.html { render :new }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1
  # PATCH/PUT /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { render :show, status: :ok, location: @club }
      else
        @club.errors
        format.html { render :edit }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy

      @club.players.each{|player| player.club_id = nil , player.save}
      @club.destroy

    respond_to do |format|
      format.html { redirect_to clubs_url, notice: 'Club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_player(player)
    @club.players << player
  end

  def remove_player(player)
    @club.players >> player
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :city)
    end
end
