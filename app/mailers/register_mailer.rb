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
    attachments.inline['emailcooptech.png'] = File.read('app/assets/images/emailcooptech.png')
    mail(
          from: "1CooptTech <management@onecooptech.org>",
          to: @registration.email, 
          cc: "management@onecooptech.org", 
          subject: "One Coop Tech 2nd General Assembly"
    )
  end
end
