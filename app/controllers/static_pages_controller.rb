class StaticPagesController < ApplicationController
  before_action :logged_in_user
  
  def search
  end
  
  def result
    if params[:search] == nil
      flash.now[:danger] ="検索に失敗しました"
      render "search"
    elsif params[:checkbox] == "1"
      @month = params[:search].in_time_zone
      @incomes = current_user.incomes.search_by_month(params[:search])
      @incomedata = current_user.incomes.search_by_month(params[:search]).group(:categories).sum(:amount)
      @outgos = current_user.outgos.search_by_month(params[:search])
      @outgodata = current_user.outgos.search_by_month(params[:search]).group(:categories).sum(:amount)
    else
      @month = params[:search].in_time_zone
      @incomes = current_user.incomes.search_by_day(params[:search])
      @outgos = current_user.outgos.search_by_day(params[:search])
      render "day_result"
    end
  end
  
  def result_day
  end

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
