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
    @TotalVote = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event, elect_position_id: @candidate.elect_position_id).sum(:vote_amount)
    @vote.entry_vote =  @event_hub.vote_power - @TotalVote
    @vote.event_hub = @event_hub
    # @vote.entry_vote = @event_hub.vote_power
    @vote.candidate = @candidate
    
  end

  def vote_review 
    @event_hub = EventHub.find(params[:e])
    @elect_positions = ElectPosition.where(coop_event: @event_hub.coop_event)
  end
  # GET /votes/1/edit
  def edit
    # set_dummy_fields
    @TotalVote = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event, elect_position_id: @vote.elect_position_id).sum(:vote_amount)
    # @vote.entry_vote =  @event_hub.vote_power + @vote.vote_amount - @TotalVote
    @vote.entry_vote =  @event_hub.vote_power - @TotalVote
  end

  # POST /votes or /votes.json
  def create
    @event_hub = EventHub.find(params[:e])
    @candidate = Candidate.find(params[:c])
    @vote = Vote.new(vote_params)
    @vote.coop_event_id = @event_hub.coop_event_id
    set_dummy_fields
    @vote.elect_position = @candidate.elect_position
    # raise "errors"
    respond_to do |format|
      if @vote.save
        format.html { redirect_to vote_votes_url(e: @event_hub, p: @vote.candidate.elect_position_id), notice: "Vote was successfully created." }
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
    @TotalVote = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event, elect_position_id: @vote.elect_position_id).sum(:vote_amount)
    @vote.entry_vote =  @event_hub.vote_power + @vote.vote_amount - @TotalVote
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_votes_url(e: @event_hub, p: @vote.candidate.elect_position_id), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end
  
  def vote_final 
    @event_hub = EventHub.find(params[:p])
    # @votes = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event)
    respond_to do |format|
      if @event_hub.update_attribute(:voted, 1) 
        @vote_update = Vote.where(event_hub_id: @event_hub.id, coop_event_id: @event_hub.coop_event.id)
        @vote_update.update_all(post: 1)
        format.html { redirect_to vote_success_votes_path(p: @event_hub.coop_event), notice: "Updated" }
      end
    end
  end
  def vote_success 
    @coop_event = CoopEvent.find(params[:p])
  end
  
  def vote
    @event_hub = EventHub.find(params[:e])
    @elect_position = ElectPosition.find_by(id: params[:p], coop_event: @event_hub.coop_event)
    @next = params[:p].to_i + 1
    @next_position = ElectPosition.find_by(id: @next)
    @vote_sum = Vote.where(event_hub: @event_hub, elect_position: @elect_position).sum(:vote_amount)
    @votes_available = @event_hub.vote_power - @vote_sum
    @candidates = Candidate.where(coop_event_id: @event_hub.coop_event_id, elect_position: @elect_position)
    #  @vote = Vote.find_by(candidate_id: @candidates, event_hub_id: @event_hub)
    @count_vote = Vote.where(elect_position: @elect_position, event_hub_id: @event_hub).count
  end
  def result 
    @elect_position = ElectPosition.all
    @event = CoopEvent.find_by(:active => 1)
  end
  # DELETE /votes/1 or /votes/1.json
  def destroy
    @p = @vote.candidate.elect_position
    @vote.destroy
    
    respond_to do |format|
      # format.html { redirect_to vote_event_hub_url(@event_hub, p: @p), notice: "Vote was successfully destroyed." }
      format.html { redirect_to vote_votes_url(e: @event_hub, p: @p), notice: "Vote was successfully destroyed." }
      # format.html { redirect_back(fallback_location: vote_event_hub_url(@event_hub, p: params[:p])) , notice: "Vote was successfully destroyed." }
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
      params.require(:vote).permit(:event_hub_id, :coop_event_id, :candidate_id, :elect_position_id, :vote_amount, :post)
    end
end
