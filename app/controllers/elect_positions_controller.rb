class ElectPositionsController < ApplicationController
  before_action :set_elect_position, only: %i[ show edit update destroy ]

  # GET /elect_positions or /elect_positions.json
  def index
    @elect_positions = ElectPosition.all
  end

  # GET /elect_positions/1 or /elect_positions/1.json
  def show
  end

  # GET /elect_positions/new
  def new
    # @elect_position = ElectPosition.new
    @coop_event = CoopEvent.find(params[:v])
    @elect_position = @coop_event.elect_positions.build
  end

  # GET /elect_positions/1/edit
  def edit
  end

  # POST /elect_positions or /elect_positions.json
  def create
    # @elect_position = ElectPosition.new(elect_position_params)
    @coop_event = CoopEvent.find(params[:v])
    @elect_position = @coop_event.elect_positions.build(elect_position_params)
    respond_to do |format|
      if @elect_position.save
        format.html { redirect_to @coop_event, notice: "Elect position was successfully created." }
        format.json { render :show, status: :created, location: @elect_position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @elect_position.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elect_positions/1 or /elect_positions/1.json
  def update
    @coop_event = CoopEvent.find(@elect_position.coop_event_id)
    respond_to do |format|
      if @elect_position.update(elect_position_params)
        format.html { redirect_to @coop_event, notice: "Elect position was successfully updated." }
        format.json { render :show, status: :ok, location: @coop_event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @elect_position.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elect_positions/1 or /elect_positions/1.json
  def destroy
    @elect_position.destroy

    respond_to do |format|
      format.html { redirect_to elect_positions_url, notice: "Elect position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elect_position
      @elect_position = ElectPosition.find(params[:id])
      @coop_event = CoopEvent.find(@elect_position.coop_event_id)
    end

    # Only allow a list of trusted parameters through.
    def elect_position_params
      params.require(:elect_position).permit(:coop_event_id, :name, :vacant)
    end
end
