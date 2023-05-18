class CoopEventsController < ApplicationController
  before_action :set_coop_event, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!
  # GET /coop_events or /coop_events.json
  def index
    @coop_events = CoopEvent.all
  end
  
  def home
    @coop_events = CoopEvent.all

  end
  # GET /coop_events/1 or /coop_events/1.json
  def show
  end

  # GET /coop_events/new
  def new
    @coop_event = CoopEvent.new
  end

  # GET /coop_events/1/edit
  def edit
  end

  # POST /coop_events or /coop_events.json
  def create
    @coop_event = CoopEvent.new(coop_event_params)

    respond_to do |format|
      if @coop_event.save
        format.html { redirect_to coop_event_url(@coop_event), notice: "Coop event was successfully created." }
        format.json { render :show, status: :created, location: @coop_event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coop_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coop_events/1 or /coop_events/1.json
  def update
    respond_to do |format|
      if @coop_event.update(coop_event_params)
        format.html { redirect_to coop_event_url(@coop_event), notice: "Coop event was successfully updated." }
        format.json { render :show, status: :ok, location: @coop_event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coop_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coop_events/1 or /coop_events/1.json
  def destroy
    @coop_event.destroy

    respond_to do |format|
      format.html { redirect_to coop_events_url, notice: "Coop event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop_event
      @coop_event = CoopEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coop_event_params
      params.require(:coop_event).permit(:name, :event_date, :description, :election, :active, 
        elect_position_param: [:id, :name, :vacant])
    end
end
