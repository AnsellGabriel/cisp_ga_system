class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    # raise "errors"
    @candidate = Candidate.find(params[:c])
    @event_hub = EventHub.find(params[:e])
    @vote = Vote.new
    set_dummy_fields
  end

  def set_dummy_fields
    # @event_hub.vote_amount = @event_hub.vote_power
    @TotalVote = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event).sum(:vote_amount)
    @vote.entry_vote =  @event_hub.vote_power - @TotalVote
    @vote.event_hub_id = @event_hub
    # @vote.entry_vote = @event_hub.vote_power
    @vote.candidate = @candidate
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes or /votes.json
  def create
    @event_hub = EventHub.find(params[:e])
    @candidate = Candidate.find(params[:c])
    @vote = Vote.new(vote_params)
    @vote.coop_event_id = @event_hub.coop_event_id
    @vote.event_hub = @event_hub
    @vote.candidate = @candidate
    
    # raise "errors"
    respond_to do |format|
      if @vote.save
        format.html { redirect_to vote_event_hub_url(@event_hub), notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_event_hub_url(@event_hub), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to vote_event_hub_url(@event_hub), notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
      @event_hub = @vote.event_hub
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:event_hub_id, :coop_event_id, :candidate_id, :vote_amount, :vote_entry, :post)
    end
end
