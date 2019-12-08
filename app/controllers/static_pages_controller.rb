class StaticPagesController < ApplicationController
  before_action :logged_in_user
  
  def search
  end
  
  def result
    if params[:search].empty?
      flash.now[:danger] ="検索に失敗しました"
      render "search"
    elsif params[:checkbox] == "1" #月ごとに検索
      @month = params[:search].in_time_zone
      @incomes = current_user.incomes.search_by_month(params[:search])    #検索された月の履歴
      @incomechart = current_user.incomes.month_category(params[:search]) #検索された月の円グラフ
      @outgos = current_user.outgos.search_by_month(params[:search])      #検索された月の履歴
      @outgochart = current_user.outgos.month_category(params[:search])   #検索された月の円グラフ
    else
      @month = params[:search].in_time_zone
      @incomes = current_user.incomes.search_by_day(params[:search])  #日単位での検索の履歴
      @outgos = current_user.outgos.search_by_day(params[:search])    #上に同じ
      render "day_result"
    end
  end

  def incomedetail  #今月の収入詳細
    @incomechart = current_user.incomes.month_category(Time.current)
    @incomes = current_user.incomes.search_by_month(Time.current).order(date: "DESC")
  end

  def outgodetail   #今月の支出詳細
    @outgochart = current_user.outgos.month_category(Time.current)
    @outgos = current_user.outgos.search_by_month(Time.current).order(date: "DESC")
  end
  
  def total
    @incomes = current_user.incomes.year(Time.current) #円グラフにする
    @outgos = current_user.outgos.year(Time.current)   #円グラフにする

    #月ごとの支出の値を負の数にする
    @outgos.each do |date, amount| 
      if !@total
        @total = {}
      end
      @total[date] = (-amount)
    end
    #収入+ 支出をして貯金額を出している
    @line = @incomes.merge(@total){|date, income, outgo| income + outgo}
  end
end
