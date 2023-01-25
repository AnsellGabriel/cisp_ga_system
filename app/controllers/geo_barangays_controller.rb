class GeoBarangaysController < ApplicationController
  before_action :set_geo_barangay, only: %i[ show edit update destroy ]

  # GET /geo_barangays or /geo_barangays.json
  def index
    @geo_barangays = GeoBarangay.all
  end

  # GET /geo_barangays/1 or /geo_barangays/1.json
  def show
  end

  # GET /geo_barangays/new
  def new
    @geo_barangay = GeoBarangay.new
  end

  # GET /geo_barangays/1/edit
  def edit
  end

  # POST /geo_barangays or /geo_barangays.json
  def create
    @geo_barangay = GeoBarangay.new(geo_barangay_params)

    respond_to do |format|
      if @geo_barangay.save
        format.html { redirect_to geo_barangay_url(@geo_barangay), notice: "Geo barangay was successfully created." }
        format.json { render :show, status: :created, location: @geo_barangay }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @geo_barangay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geo_barangays/1 or /geo_barangays/1.json
  def update
    respond_to do |format|
      if @geo_barangay.update(geo_barangay_params)
        format.html { redirect_to geo_barangay_url(@geo_barangay), notice: "Geo barangay was successfully updated." }
        format.json { render :show, status: :ok, location: @geo_barangay }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geo_barangay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_barangays/1 or /geo_barangays/1.json
  def destroy
    @geo_barangay.destroy

    respond_to do |format|
      format.html { redirect_to geo_barangays_url, notice: "Geo barangay was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo_barangay
      @geo_barangay = GeoBarangay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geo_barangay_params
      params.require(:geo_barangay).permit(:geo_region_id, :geo_province_id, :geo_municipality_id, :name)
    end
end
