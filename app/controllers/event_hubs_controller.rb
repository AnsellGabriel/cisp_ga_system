class EventHubsController < ApplicationController
  include Pagy::Backend
  before_action :set_event_hub, only: %i[ show edit update destroy vote ]
  # before_action :authenticate_user!
  # GET /event_hubs or /event_hubs.json
  def index
    # @event_hubs = EventHub.all
    @q = EventHub.ransack(params[:q])
    # @pagy, @event_hubs = pagy(EventHub)
    @pagy, @event_hubs = pagy(@q.result(distinct: true).order(created_at: :desc), items: 10)
    
  end

  def voter_code 
    # raise "errors"
    respond_to do |format|
      if @event_hub.update_attribute(:voted, 1)
        format.html { redirect_back fallback_location: registrations_path, notice: "Updated" }
      end
      format.html { redirect_to voter_code_event_hubs_url(p: 1), notice: "Event hub was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def home 
    
  end

  def coop 
    @event_hubs = EventHub.where(coop_event_id: params[1])
  end


  def admin 
    
  end
  # GET /event_hubs/1 or /event_hubs/1.json
  def show
  end
  def vote 
    @elect_position = ElectPosition.find_by(id: params[:p], coop_event: @event_hub.coop_event)
    @next = params[:p].to_i + 1
    @next_position = ElectPosition.find_by(id: @next)
    @vote_sum = Vote.where(event_hub: @event_hub, elect_position: @elect_position).sum(:vote_amount)
    @votes_available = @event_hub.vote_power - @vote_sum
    @candidates = Candidate.where(coop_event_id: @event_hub.coop_event_id, elect_position: @elect_position)
    #  @vote = Vote.find_by(candidate_id: @candidates, event_hub_id: @event_hub)
    @count_vote = Vote.where(elect_position: @elect_position, event_hub_id: @event_hub).count
   
  end
  # GET /event_hubs/new
  def new
    @event_hub = EventHub.new
  end

  # GET /event_hubs/1/edit
  def edit
  end

  # POST /event_hubs or /event_hubs.json
  def create
    @event_hub = EventHub.new(event_hub_params)

    respond_to do |format|
      if @event_hub.save
        format.html { redirect_to event_hub_url(@event_hub), notice: "Event hub was successfully created." }
        format.json { render :show, status: :created, location: @event_hub }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_hubs/1 or /event_hubs/1.json
  def update
    respond_to do |format|
      if @event_hub.update(event_hub_params)
        format.html { redirect_to event_hub_url(@event_hub), notice: "Event hub was successfully updated." }
        format.json { render :show, status: :ok, location: @event_hub }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_hubs/1 or /event_hubs/1.json
  def destroy
    @event_hub.destroy

    respond_to do |format|
      format.html { redirect_to event_hubs_url, notice: "Event hub was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_hub
      @event_hub = EventHub.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_hub_params
      params.require(:event_hub).permit(:coop_event_id, :cooperative_id, :capital, :vote_power, :vote_code, :voted, :vote_amount,
        registration_param: [:id, :last_name, :first_name, :middle_name, :birth_date, :mobile_number, :email, :guest_type, :attendance, :id_pic, :board_reso ],
        candidate_param: [:id, :elect_position_id, :last_name, :first_name, :middle_name, :suffix, :birth_date, :address, :mobile_number, :email, :education, :company, :occupation, :status ])
    end
end
