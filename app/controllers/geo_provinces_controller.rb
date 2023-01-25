class GeoProvincesController < ApplicationController
  before_action :set_geo_province, only: %i[ show edit update destroy ]

  # GET /geo_provinces or /geo_provinces.json
  def index
    @geo_provinces = GeoProvince.all
  end

  # GET /geo_provinces/1 or /geo_provinces/1.json
  def show
  end

  def selected 
    @target = params[:target]
      @municipality = GeoMunicipality.where(geo_province_id: params[:id]).order(:name)
      respond_to do |format|
        format.turbo_stream
      end
  end
  # GET /geo_provinces/new
  def new
    @geo_province = GeoProvince.new
  end

  # GET /geo_provinces/1/edit
  def edit
  end

  # POST /geo_provinces or /geo_provinces.json
  def create
    @geo_province = GeoProvince.new(geo_province_params)

    respond_to do |format|
      if @geo_province.save
        format.html { redirect_to geo_province_url(@geo_province), notice: "Geo province was successfully created." }
        format.json { render :show, status: :created, location: @geo_province }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @geo_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geo_provinces/1 or /geo_provinces/1.json
  def update
    respond_to do |format|
      if @geo_province.update(geo_province_params)
        format.html { redirect_to geo_province_url(@geo_province), notice: "Geo province was successfully updated." }
        format.json { render :show, status: :ok, location: @geo_province }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geo_province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geo_provinces/1 or /geo_provinces/1.json
  def destroy
    @geo_province.destroy

    respond_to do |format|
      format.html { redirect_to geo_provinces_url, notice: "Geo province was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geo_province
      @geo_province = GeoProvince.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def geo_province_params
      params.require(:geo_province).permit(:geo_region_id, :name)
    end
end
