require 'test_helper'

class AddIncomeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:haruki)
  end
  
  test "invalid income infromation" do
    log_in_as(@user)
    get new_income_path
    assert_no_difference "Income.count" do
      post incomes_path, params: {income: {amount: nil, categories: "食費", memo: "", date: "2019-12-02 00:00:00" } }
    end
    assert_template "incomes/new"
  end
end
