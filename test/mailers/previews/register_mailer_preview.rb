# Preview all emails at http://localhost:3000/rails/mailers/register_mailer
class RegisterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/register_mailer/register_created
  def register_created
    RegisterMailer.with(registration: Registration.first, event_hub: EventHub.first).register_created
  end

end
