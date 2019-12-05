require 'test_helper'

class OutgoTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:haruki)
    @outgo = @user.outgos.build(amount: 1000, categories: "食費", date: "12:00:00")
  end
  
  test "should be valid" do
    assert @outgo.valid?
  end
  
  test "outgo should be positive number" do
    @outgo.amount = 0
    assert_not @outgo.valid?
  end
end
