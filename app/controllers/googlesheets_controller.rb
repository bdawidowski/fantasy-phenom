class GooglesheetsController < ApplicationController
  before_action :set_googlesheet, only: [:show, :edit, :update, :destroy]
  before_action :is_subscribed?
  before_action :is_admin?, except: [:index]
 
  # GET /googlesheets
  # GET /googlesheets.json
  def index
    @nba = Googlesheet.find_by_sport('NBA')
    @nfl = Googlesheet.find_by_sport('NFL')
    @mlb = Googlesheet.find_by_sport('MLB')
  end

  # GET /googlesheets/1
  # GET /googlesheets/1.json
  def show
  end

  # GET /googlesheets/new
  def new
    @googlesheet = Googlesheet.new
  end

  # GET /googlesheets/1/edit
  def edit
  end

  # POST /googlesheets
  # POST /googlesheets.json
  def create
    @googlesheet = Googlesheet.new(googlesheet_params)

    respond_to do |format|
      if @googlesheet.save
        format.html { redirect_to @googlesheet, notice: 'Googlesheet was successfully created.' }
        format.json { render :index, status: :created, location: @googlesheet }
      else
        format.html { render :new }
        format.json { render json: @googlesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /googlesheets/1
  # PATCH/PUT /googlesheets/1.json
  def update
    respond_to do |format|
      if @googlesheet.update(googlesheet_params)
        format.html { redirect_to @googlesheet, notice: 'Googlesheet was successfully updated.' }
        format.json { render :index, status: :ok, location: @googlesheet }
      else
        format.html { render :edit }
        format.json { render json: @googlesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /googlesheets/1
  # DELETE /googlesheets/1.json
  def destroy
    @googlesheet.destroy
    respond_to do |format|
      format.html { redirect_to googlesheets_url, notice: 'Googlesheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_googlesheet
      @googlesheet = Googlesheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def googlesheet_params
      params.require(:googlesheet).permit(:sport.upcase, :link, :date_for, :status)
    end
end
