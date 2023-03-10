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
    attachments.inline['email_header.jpg'] = File.read('app/assets/images/email_header.jpg')
    mail(
          from: "1cispga@gmail.com",
          to: @registration.email, 
          cc: "1cispga@gmail.com", 
          subject: "49th GA Registration"
    )
  end
end
