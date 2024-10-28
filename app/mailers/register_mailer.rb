class RegisterMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.register_mailer.register_created.subject
  #
  def register_created
    @registration = params[:registration]
    @name = @registration.get_fullname
    @guest_type= @registration.guest_type
    
    # @registration = Registration.find(params[:id])
    # @email = @email.shuffle.first.email
    @event_hub = params[:event_hub]
    @voter = @event_hub.vote_code
    @greeting = "Hi"
    attachments.inline['cooptech_email.png'] = File.read('app/assets/images/cooptech_email.png')
    mail(
          from: "info@onecoop.tech",
          to: @registration.email, 
          cc: "info@onecoop.tech", 
          subject: "3rd OCTS GA Registration"
    )
  end
end
