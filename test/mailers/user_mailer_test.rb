require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password_reset" do
    user = users(:haruki)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "パスワード再設定", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end
end
