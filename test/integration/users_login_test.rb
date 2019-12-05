require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:haruki)
  end
  
  test "login with valid information followed by logout" do
    get root_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to index_url
    follow_redirect!
    assert_template 'users/index'
    assert_select "a[href=?]", root_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", logout_path, count: 0
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    #記憶する
    log_in_as(@user, remember_me: '1')
    delete logout_path
    #記憶しない
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
