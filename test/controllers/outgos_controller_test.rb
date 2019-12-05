require 'test_helper'

class OutgosControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:haruki)
  end
  
  test "should get home" do
    log_in_as(@user)
    get totaloutgo_path
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_outgo_path
    assert_response :success
  end

end
