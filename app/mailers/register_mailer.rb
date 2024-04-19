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
    attachments.inline['chmf_email.png'] = File.read('app/assets/images/chmf_email.png')
    mail(
          from: "9thaga.1coophealth@gmail.com",
          to: @registration.email, 
          cc: "9thaga.1coophealth@gmail.com", 
          subject: "CHMF 9th GA Registration"
    )
  end
end
