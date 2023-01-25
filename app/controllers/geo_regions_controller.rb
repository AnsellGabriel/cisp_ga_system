class GeoRegionsController < ApplicationController
    before_action :set_geo_region, only: %i[ show edit update destroy ]
  
    # GET /geo_regions or /geo_regions.json
    def index
      @geo_regions = GeoRegion.all
    end
  
    # GET /geo_regions/1 or /geo_regions/1.json
    def show
    end
  
    def selected 
      @target = params[:target]
      @provinces = GeoProvince.where(geo_region_id: params[:id]).order(:name)
      respond_to do |format|
        format.turbo_stream
      end
    end
    # GET /geo_regions/new
    def new
      @geo_region = GeoRegion.new
    end
  
    # GET /geo_regions/1/edit
    def edit
    end
  
    # POST /geo_regions or /geo_regions.json
    def create
      @geo_region = GeoRegion.new(geo_region_params)
  
      respond_to do |format|
        if @geo_region.save
          format.html { redirect_to geo_region_url(@geo_region), notice: "Geo region was successfully created." }
          format.json { render :show, status: :created, location: @geo_region }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @geo_region.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /geo_regions/1 or /geo_regions/1.json
    def update
      respond_to do |format|
        if @geo_region.update(geo_region_params)
          format.html { redirect_to geo_region_url(@geo_region), notice: "Geo region was successfully updated." }
          format.json { render :show, status: :ok, location: @geo_region }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @geo_region.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /geo_regions/1 or /geo_regions/1.json
    def destroy
      @geo_region.destroy
  
      respond_to do |format|
        format.html { redirect_to geo_regions_url, notice: "Geo region was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_geo_region
        @geo_region = GeoRegion.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def geo_region_params
        params.require(:geo_region).permit(:name, :psgc_code)
      end
  end
  