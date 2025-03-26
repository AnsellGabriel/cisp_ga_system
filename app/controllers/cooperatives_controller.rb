class CooperativesController < ApplicationController
  before_action :set_cooperative, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!
  # GET /cooperatives or /cooperatives.json
  def index
    @cooperatives = Cooperative.all
  end

  # GET /cooperatives/1 or /cooperatives/1.json
  def show
  end

  # GET /cooperatives/new
  def new
    @cooperative = Cooperative.new
  end

  # GET /cooperatives/1/edit
  def edit
    @event_hub = EventHub.find_by(cooperative_id: @cooperative.id)
  end

  # POST /cooperatives or /cooperatives.json
  def create
    @cooperative = Cooperative.new(cooperative_params)

    respond_to do |format|
      if @cooperative.save
        format.html { redirect_to event_hubs_url, notice: "Cooperative was successfully created." }
        format.json { render :show, status: :created, location: @cooperative }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cooperative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cooperatives/1 or /cooperatives/1.json
  def update
    @event_hub = EventHub.find_by(cooperative_id: @cooperative.id)
    respond_to do |format|
      if @cooperative.update(cooperative_params)
        format.html { redirect_to event_page_path(@event_hub), notice: "Cooperative was successfully updated." }
        format.json { render :show, status: :ok, location: @cooperative }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cooperative.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cooperatives/1 or /cooperatives/1.json
  def destroy
    @cooperative.destroy

    respond_to do |format|
      format.html { redirect_to cooperatives_url, notice: "Cooperative was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cooperative
    @cooperative = Cooperative.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cooperative_params
    params.require(:cooperative).permit(:name, :geo_region_id, :geo_province_id, :geo_municipality_id, :geo_barangay_id, :street, :tin, :registration_no, :coop_type, :email, :contact_no)
  end
end
