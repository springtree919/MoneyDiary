require 'test_helper'

class IncomeTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:haruki)
    @income = @user.incomes.build(amount: 1000, categories: "食費", date: "12:00:00")
  end
  
  test "should be valid" do
    assert @income.valid?
  end
  
  test "income should be positive number" do
    @income.amount = 0
    assert_not @income.valid?
  end
end
