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
      @incomechart = current_user.incomes.month_category(params[:search])
      @outgos = current_user.outgos.search_by_month(params[:search])
      @outgochart = current_user.outgos.month_category(params[:search])
    else
      @month = params[:search].in_time_zone
      @incomes = current_user.incomes.search_by_day(params[:search])
      @outgos = current_user.outgos.search_by_day(params[:search])
      render "day_result"
    end
  end

  def incomedetail
    @incomes = current_user.incomes.month_category(Time.current)
    @monthincomes = current_user.incomes.search_by_month(Time.current).order(date: "DESC")
  end

  def outgodetail
    @outgos = current_user.outgos.month_category(Time.current)
    @monthoutgos = current_user.outgos.search_by_month(Time.current).order(date: "DESC")
  end
  
  def total
    @incomes = current_user.incomes.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
    @outgos = current_user.outgos.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
    @incomedata = current_user.incomes.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
    @outgodata = current_user.outgos.where(date: Time.current.all_year).group_by_month(:date).sum(:amount)
    
    @outgos.each do |date, amount| 
      if !@total
        @total = {}
      end
      @total[date] = (-amount)
    end
    @dif = @incomes.merge(@total){|date, amount1, amount2| amount1 + amount2}
  end
end
