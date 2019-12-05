class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def incomedetail
    @incomes = current_user.incomes.where(date: Time.current.all_month).group(:categories).sum(:amount)
    @incomedata = current_user.incomes.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
  end

  def outgodetail
    @outgos = current_user.outgos.where(date: Time.current.all_month).group(:categories).sum(:amount)
    @outgodata = current_user.outgos.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
  end
  
  def last_month
    @incomes = current_user.incomes.where(date: Time.current.prev_month.all_month).group(:categories).sum(:amount)
  end
end
