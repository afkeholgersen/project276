require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user=User.new
    user.email="to@example.com"
    user.username="Example"

    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
  end

end
