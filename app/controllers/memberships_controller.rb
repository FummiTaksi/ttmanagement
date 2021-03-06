class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [:new, :create, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index

  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    if !clubowner_signed_in or current_player.club.nil?
      flash[:error] = "You have no acces to this section!"
      redirect_to root_path
    else
      @membership = Membership.new
      @players = Player.all.select {|player| player.club_id.nil?}
      @club = current_player.club
    end

  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create

    membership = Membership.new(membership_params)

    respond_to do |format|
      if membership.save
        membership.club_id = current_player.club.id
        @player = Player.find_by id: membership.player_id
        @player.club_id = membership.club_id
        @club = current_player.club
        @club.players << @player
        format.html { redirect_to current_player.club, notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: current_player.club}

      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @player = Player.find_by id: @membership.player_id
    @club = current_player.club
    @club.players.delete(@player)
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to current_player, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:player_id, :club_id)
    end
end
