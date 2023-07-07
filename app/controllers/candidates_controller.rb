class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!
  # GET /candidates or /candidates.json
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1 or /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    # @candidate = Candidate.new
    # if params[:p] == "notmodal"
    #   @candidate = Candidate.new
    # else
    unless params[:p] == "notmodal"
      @event_hub = EventHub.find(params[:v])
      @candidate = @event_hub.candidates.build
    end
   
     set_dummy_register
  end
  def set_dummy_register 
    @candidate.last_name = FFaker::Name.last_name
    @candidate.first_name = FFaker::Name.first_name
    @candidate.middle_name = FFaker::Name.name[0]
    @candidate.email = @candidate.last_name.downcase + "@email.com"
  end
  def new_edit 
    @candidate = Candidate.new
    @event_hub = EventHub.first
    # set_dummy_register
  end
  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates or /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)
    # @event_hub = EventHub.find(params[:v])
    # @candidate = @event_hub.candidates.build(candidate_params)
    @candidate.coop_event_id = CoopEvent.find_by(:active => 1).id
    respond_to do |format|
      if @candidate.save
        format.html { redirect_to candidates_path, notice: "Candidate was successfully created." }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1 or /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to candidate_url(@candidate), notice: "Candidate was successfully updated." }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1 or /candidates/1.json
  def destroy
    @candidate.destroy

    respond_to do |format|
      format.html { redirect_to candidates_url, notice: "Candidate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:event_hub_id, :elect_position_id, :coop_event_id, :last_name, :first_name, :middle_name, :suffix, :birth_date, :address, :mobile_number, :email, :education, :company, :occupation, :status, :picture, :resume, :board_reso)
    end
end
