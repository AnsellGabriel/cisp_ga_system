class RegistrationsController < ApplicationController
  include Pagy::Backend
  before_action :set_registration, only: %i[ show edit update destroy attend ]

  # GET /registrations or /registrations.json
  def index
    # @registrations = Registration.all

    @q = Registration.ransack(params[:q])
    @pagy, @registrations = pagy(@q.result(distinct: true).order(created_at: :desc), items: 10)
  end

  def dash_board 
    @attend_principal = Registration.where(:attend => 1, :guest_type => "Principal Delegate").count
    @attend_associate = Registration.where(:attend => 1, :guest_type => "Accompanying Delegate").count
    @principal_count = Registration.where(:guest_type => "Principal Delegate").count
    @accompanying_count = Registration.where(:guest_type => "Accompanying Delegate").count
    @attend_venue = Registration.where(:attendance =>  "I will attend physically in the venue").count
    @attend_zoom = Registration.where(:attendance =>  "I will attend virtually via zoom").count
    @attend_kit = Registration.where(:attendance =>  "I will attend virtually and will avail AGA kit (will shoulder shipping cost)").count
  end

  # GET /registrations/1 or /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @event_hub = EventHub.find(params[:v])
    @registration = @event_hub.registrations.build
    set_dummy_register
  end
  def set_dummy_register 
    @eh = EventHub.all
    @registration.last_name = FFaker::Name.last_name
    @registration.first_name = FFaker::Name.first_name
    @registration.middle_name = FFaker::Name.name[0]
    @registration.event_hub_id = @eh.shuffle.first.id
    @registration.email = @registration.last_name.downcase + "@email.com"
  end

  def new_modal
      # puts "@@@@@#{params[:v]}"
      @registration = Registration.new
      set_dummy_register
    
  end
  # GET /registrations/1/edit
  def edit
  end

  def edit_modal 
    # raise "errors"
    #  puts "#######{params[:registration_id]}"
    
     @registration = Registration.find_by(id: params[:registration_id])
      @event_hub = EventHub.find(@registration.event_hub_id)
  end
  # POST /registrations or /registrations.json
  def create
     puts "@@@@@#{params[:q]}"
    # raise "errors"
    if params[:q] == "notmodal"
      @registration = Registration.new(registration_params)
      @event_hub = EventHub.find(@registration.event_hub_id)
    else
      puts "@@@ modal #{params[:v]}"
      @event_hub = EventHub.find(params[:v])
      @registration = @event_hub.registrations.build(registration_params)
    end
    @registration.attend = 0
    # raise "errors"
    respond_to do |format|
      if @registration.save
          RegisterMailer.with(registration: @registration, event_hub: @event_hub).register_created.deliver_later
          format.html { redirect_to event_page_path(@event_hub), notice: "Registration was successfully created." }
        # format.html { redirect_to registration_url(@registration), notice: "Registration was successfully created." }
        format.json { render :show, status: :created, location: @registration }
      else
        if params[:q] == "notmodal"  
          format.html { render :new_modal, status: :unprocessable_entity }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
          format.turbo_stream { render :form_update, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /registrations/1 or /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        # format.html { redirect_to event_page_path(@event_hub), notice: "Registration was successfully updated." }
        format.html { redirect_back fallback_location: root_path, notice: "Registration was successfully updated." }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit_modal, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1 or /registrations/1.json
  def destroy
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url, notice: "Registration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def attend 
    if @registration.attend 
      @attend = 0
    else
      @attend = 1
    end
    respond_to do |format|
      if @registration.update_attribute(:attend, @attend)
        format.html { redirect_back fallback_location: registrations_path, notice: "Updated" }
      end
    end
    
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
      @event_hub = EventHub.find(@registration.event_hub_id)
    end

    # Only allow a list of trusted parameters through.
    def registration_params
      params.require(:registration).permit(:event_hub_id, :last_name, :first_name, :middle_name, :birth_date, :mobile_number, :email, :guest_type, :attendance, :id_pic, :board_reso, :attend)
    end
end
