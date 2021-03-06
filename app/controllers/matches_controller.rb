class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [:show, :index]
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
    notclub = Player.where club_id:nil
    @players = Player.all - notclub
  end

  # GET /matches/1/edit
  def edit
    @players = Player.all
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    @players = Player.all
    @homeplayer = @match.player1
    @awayplayer = @match.player2

    respond_to do |format|
      if @match.save
        ##@homeplayer.matches << @match
        ##@awayplayer.matches << @match
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    @players = Player.all
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:homefirst, :awayfirst, :homesecond, :awaysecond, :homethird, :awaythird, :homefourth, :awayfourth, :homefifth, :awayfifth, :player1_id, :player2_id)
    end
end
