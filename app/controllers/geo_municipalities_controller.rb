class GeoMunicipalitiesController < ApplicationController
  before_action :set_geo_municipality, only: %i[ show edit update destroy ]

  # GET /geo_municipalities or /geo_municipalities.json
  def index
    @geo_municipalities = GeoMunicipality.all
  end

  # GET /geo_municipalities/1 or /geo_municipalities/1.json
  def show
  end

  def selected 
    @target = params[:target]
      @barangay = GeoBarangay.where(geo_municipality_id: params[:id]).order(:name)
      respond_to do |format|
        format.turbo_stream
      end
  end
  # GET /geo_municipalities/new
  def new
    @geo_municipality = GeoMunicipality.new
  end

  # GET /geo_municipalities/1/edit
  def edit
  end

  # POST /geo_municipalities or /geo_municipalities.json
  def create
    @geo_municipality = GeoMunicipality.new(geo_municipality_params)

    respond_to do |format|
      if @geo_municipality.save
        format.html { redirect_to geo_municipality_url(@geo_municipality), notice: "Geo municipality was successfully created." }
        format.json { render :show, status: :created, location: @geo_municipality }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @geo_municipality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geo_municipalities/1 or /geo_municipalities/1.json
  def update
    respond_to do |format|
      if @geo_municipality.update(geo_municipality_params)
        format.html { redirect_to geo_municipality_url(@geo_municipality), notice: "Geo municipality was successfully updated." }
        format.json { render :show, status: :ok, location: @geo_municipality }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geo_municipality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_municipalities/1 or /geo_municipalities/1.json
  def destroy
    @geo_municipality.destroy

    respond_to do |format|
      format.html { redirect_to geo_municipalities_url, notice: "Geo municipality was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo_municipality
      @geo_municipality = GeoMunicipality.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geo_municipality_params
      params.require(:geo_municipality).permit(:geo_region_id, :geo_province_id, :name)
    end
end
