require "test_helper"

class RegisterMailerTest < ActionMailer::TestCase
  test "register_created" do
    mail = RegisterMailer.register_created
    assert_equal "Register created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
