class RegistrationsController < ApplicationController
  include Pagy::Backend
  require "csv"
  before_action :set_registration, only: %i[ show edit update destroy attend paid ]
  before_action :authenticate_user!, only: :index
  # before_action :authenticate_user!
  # GET /registrations or /registrations.json
  def data_privacy
  end

  def index
    # @registrations = Registration.all
    # :authenticate_user!
    @q = Registration.ransack(params[:q])
    @pagy, @registrations = pagy(@q.result(distinct: true).order(created_at: :desc), items: 10)

    respond_to do |format|
      format.html
      format.csv do
        send_data Registration.to_csv, filename: "register_asof_#{Date.today.to_s}.csv", content_type: "text/csv"
      end
    end
  end

  def dash_board
    @registrations = Registration.all
    @event_hubs = EventHub.all
    # @attend_principal = Registration.where(:attend => 1, :guest_type => "Principal Delegate").count
    # @attend_associate = Registration.where(:attend => 1, :guest_type => "Accompanying Delegate").count
    # @attend_youngleader = Registration.where(:attend => 1, :guest_type => "Young Coop leader").count
    @tentative = Registration.where(:tentative => 1).count
    @t_shirt_sizes = Registration.group(:size).count
    @t_shirt_count = Registration.count
    @dietary_group = Registration.group(:dietary).count

    @count_paid = Registration.where(:paid => 1).count
    @count_unpaid = Registration.where("price > ? AND paid = ?", 0, 0).count
    @paid_participants = Registration.where(:paid => 1).sum(:price)
    @unpaid_participants = Registration.where(paid: [nil, 0]).sum(:price)
    @principal_count = Registration.where(:guest_type => "Principal Delegate").count
    # @principal_venue = Registration.group(:attendance).where(:guest_type => "Principal Delegate").count
    @accompanying_count = Registration.where(:guest_type => "Accompanying Delegate").count
    # @accompanying_venue = Registration.group(:attendance).where(:guest_type =>  "Accompanying Delegate").count
    @acoompanying_paid = Registration.where(:guest_type => "Accompanying Delegate", :paid => 1)
    @youngleader_count = Registration.where(:guest_type => "Young Coop leader").count
    # @youngleader_venue = Registration.group(:attendance).where(:guest_type => "Young Coop leader").count
    @awardee_count = Registration.where(:award => 1).count
    @awardee_type = Registration.group(:guest_type).where(:award => 1).count
    # @attend_venue = Registration.group(:attendance).count
    # @attend_shares = Registration.joins(:event_hub).where(:attend => 1, :guest_type => "Principal Delegate").sum(:vote_power)
    @coop_event = CoopEvent.find_by(:active => 1)
    @total_shares = EventHub.where(coop_event: @coop_event).sum(:vote_power)
    # @quorum = (@attend_shares / @total_shares) * 100
    # @quorum = 0

  end

  # GET /registrations/1 or /registrations/1.json
  def show
  end

  def how_to_vote
  end

  # GET /registrations/new
  def new
    @event_hub = EventHub.find(params[:v])
    @registration = @event_hub.registrations.build

    #  set_dummy_register
  end

  def set_dummy_register
    @eh = EventHub.all
    @registration.last_name = FFaker::Name.last_name
    @registration.first_name = FFaker::Name.first_name
    @registration.middle_name = FFaker::Name.name[0]
    @registration.event_hub_id = @eh.shuffle.first.id
    @registration.email = "ansellgabriel@gmail.com"
    @registration.mobile_number = "+639127123459"
    @registration.birth_date = "08/09/1983"
    @registration.guest_type = "Accompanying Delegate"
    @registration.attendance = "I will attend physically in the venue"
    @registration.event_hub_id = @eh.shuffle.first.id
    @registration.coop_tin = 123
    @registration.size = "Large"
  end

  def new_modal
    # puts "@@@@@#{params[:v]}"
    @registration = Registration.new
    #  set_dummy_register

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

  def get_price
    if @registration.guest_type == "Accompanying Delegate"
      if Date.current >= Date.new(2024, 3, 1)
        @registration.price = 13000
      end
      if Date.current <= Date.new(2024, 2, 29)
        @registration.price = 11000
      end
      if Date.current <= Date.new(2023, 12, 31)
        @registration.price = 9000
      end
      if Date.current <= Date.new(2023, 8, 31)
        @registration.price = 7000
      end
      @registration.paid = 0
      @registration.award = 0
    end
    @count_yl = Registration.where(:event_hub => @registration.event_hub, :guest_type => "Young Coop leader").count
    # raise "errors #{@count_yl}"
    if Registration.where(:event_hub => @registration.event_hub, :guest_type => "Young Coop leader").count > 0
      if @registration.guest_type == "Young Coop leader"
        if Date.current >= Date.new(2024, 3, 1)
          @registration.price = 13000
        end
        if Date.current <= Date.new(2024, 2, 29)
          @registration.price = 11000
        end
        if Date.current <= Date.new(2023, 12, 31)
          @registration.price = 9000
        end
        if Date.current <= Date.new(2023, 8, 31)
          @registration.price = 7000
        end
      end
    end
  end

  # POST /registrations or /registrations.json
  def create
    #  puts "@@@@@#{params[:q]}"
    # raise "errors"
    if params[:q] == "notmodal"
      @registration = Registration.new(registration_params)
      @event_hub = EventHub.find(@registration.event_hub_id)
      @cooperative = Cooperative.find(@event_hub.cooperative_id)
    else
      # puts "@@@ modal #{params[:v]}"
      @event_hub = EventHub.find(params[:v])
      @registration = @event_hub.registrations.build(registration_params)
      @cooperative = Cooperative.find(@event_hub.cooperative_id)
      @registration.coop_tin = @cooperative.tin
    end
    @registration.attend = 0
    @registration.price = 2800 if @registration.guest_type == "Accompanying Delegate"
    # get_price

    # unless @registration.guest_type == 'Accompanying Delegate'
    #   if Registration.where(:award => 1).count < 100
    #     @registration.award = 1
    #   else
    #     @registration.award = 0
    #   end
    # end
    # raise "errors"
    respond_to do |format|
      if @registration.save
        # @registration.get_price
        @cooperative.update_attribute(:tin, @registration.coop_tin)
        # unless @registration.guest_type == 'Accompanying Delegate'
        RegisterMailer.with(registration: @registration, event_hub: @event_hub).register_created.deliver_later
        # end
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

    @registration.attend = @attend
    @registration.attend_date = DateTime.now
    respond_to do |format|
      if @registration.update_attribute(:attend, @attend)
        if @registration.guest_type == "Principal Delegate"
          @event_hub.update!(attend: @attend)
        end
        format.html { redirect_back fallback_location: registrations_path, notice: "Updated" }
      end
    end
  end

  def paid
    if @registration.paid
      @paid = 0
    else
      @paid = 1
    end
    # @award_count = Registration.where(:award => 1).count
    # raise "errors @@ {#@award_count}"
    # if Registration.where(:award => 1).count < 5
    #   @award = 1
    # else
    #   @award = 0
    # end
    respond_to do |format|
      # if @registration.update!(paid:@paid, award:@award)
      if @registration.update!(paid: @paid)
        # raise "error"
        # @registration.update_attribute(:attend_date, DateTime.now)
        format.html { redirect_back fallback_location: registrations_path, notice: "Updated" }
      else
        format.html { render :edit_modal, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
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
    params.require(:registration).permit(:event_hub_id, :last_name, :first_name, :middle_name, :birth_date, :mobile_number, :email, :guest_type, :attendance, :id_pic, :board_reso, :attend, :coop_tin, :attend_date, :price, :paid, :award, :size, :tentative, :dietary)
  end
end
