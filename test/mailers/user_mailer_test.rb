require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user=User.new
    user.email="to@example.com"
    user.username="example"
    user.password="password"
    mail = UserMailer.password_reset(user[:id])
    assert_equal "Password Reset", mail.subject
    assert_equal [user.email], mail.to
  end

end
