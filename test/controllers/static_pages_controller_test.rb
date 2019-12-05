require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:haruki)
  end
  
  test "should get incomedetail" do
    log_in_as(@user)
    get incomedetail_path
    assert_response :success
  end

  test "should get outgodetail" do
    log_in_as(@user)
    get outgodetail_path
    assert_response :success
  end

end
