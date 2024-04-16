class ReferendumsController < ApplicationController
  before_action :set_referendum, only: %i[ show edit update destroy ]


  def submit_answers
    @event_hub = EventHub.find(params[:e])
    questions = Referendum.where(active: true)
    begin
      answers = params.require(:question).permit!
      
      if (questions.size != answers.to_h.size) or answers.nil?
        raise error
      end
    rescue
      return redirect_to new_referendum_response_path, notice:"Please answer all proposal"
    end
  
    ActiveRecord::Base.transaction do 
    begin
      answers.each do |answer|
        ref = Referendum.find(answer[0].to_i)
        # ref.referendum_responses.create!(member: @member , response: answer[1][:answer])
        ref_res = ReferendumResponse.find_or_initialize_by(event_hub: @event_hub, referendum: ref)
        ref_res.response = answer[1][:answer]
        ref_res.vote_amount = @event_hub.vote_power
        ref_res.save!

      end
      rescue ActiveRecord::Rollback => e
        return redirect_to new_referendum_response_path, notice:"Must select answer."
      end
    end
    respond_to do |format|
      format.html { redirect_to vote_success_votes_path(p: 1), notice: "Referendum was successfully created." }
    end
  end
  # GET /referendums or /referendums.json
  def index
    @referendums = Referendum.all
  end

  # GET /referendums/1 or /referendums/1.json
  def show
  end

  # GET /referendums/new
  def new
    @referendum = Referendum.new
  end

  # GET /referendums/1/edit
  def edit
  end

  # POST /referendums or /referendums.json
  def create
    @referendum = Referendum.new(referendum_params)

    respond_to do |format|
      if @referendum.save
        format.html { redirect_to referendum_url(@referendum), notice: "Referendum was successfully created." }
        format.json { render :show, status: :created, location: @referendum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @referendum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referendums/1 or /referendums/1.json
  def update
    respond_to do |format|
      if @referendum.update(referendum_params)
        format.html { redirect_to referendum_url(@referendum), notice: "Referendum was successfully updated." }
        format.json { render :show, status: :ok, location: @referendum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @referendum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referendums/1 or /referendums/1.json
  def destroy
    @referendum.destroy

    respond_to do |format|
      format.html { redirect_to referendums_url, notice: "Referendum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referendum
      @referendum = Referendum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def referendum_params
      params.require(:referendum).permit(:name, :active)
    end
end
