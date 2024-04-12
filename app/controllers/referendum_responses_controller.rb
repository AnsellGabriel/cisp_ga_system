class ReferendumResponsesController < ApplicationController
  before_action :set_referendum_response, only: %i[ show edit update destroy ]

  # GET /referendum_responses or /referendum_responses.json
  def index
    @referendum_responses = ReferendumResponse.all
  end

  # GET /referendum_responses/1 or /referendum_responses/1.json
  def show
  end

  # GET /referendum_responses/new
  def new
    @referendum_response = ReferendumResponse.new
    @referendums = Referendum.where(active: 1)
    @event_hub = EventHub.find(params[:e])
  end

  # GET /referendum_responses/1/edit
  def edit
  end

  # POST /referendum_responses or /referendum_responses.json
  def create
    @referendum_response = ReferendumResponse.new(referendum_response_params)

    respond_to do |format|
      if @referendum_response.save
        format.html { redirect_to referendum_response_url(@referendum_response), notice: "Referendum response was successfully created." }
        format.json { render :show, status: :created, location: @referendum_response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @referendum_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referendum_responses/1 or /referendum_responses/1.json
  def update
    respond_to do |format|
      if @referendum_response.update(referendum_response_params)
        format.html { redirect_to referendum_response_url(@referendum_response), notice: "Referendum response was successfully updated." }
        format.json { render :show, status: :ok, location: @referendum_response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @referendum_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referendum_responses/1 or /referendum_responses/1.json
  def destroy
    @referendum_response.destroy

    respond_to do |format|
      format.html { redirect_to referendum_responses_url, notice: "Referendum response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referendum_response
      @referendum_response = ReferendumResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def referendum_response_params
      params.require(:referendum_response).permit(:event_hub_id, :referendum_id, :response)
    end
end
