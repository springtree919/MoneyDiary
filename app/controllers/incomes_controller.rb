class IncomesController < ApplicationController
  before_action :logged_in_user
  
  def home
    @incomes = current_user.incomes.paginate(page: params[:page]).order(date: "DESC")
  end
  
  def index

  end
  
  def new
    @income = Income.new
  end
  
  def create
    @income = current_user.incomes.build(income_params)
    if @income.save
      redirect_to index_path
    else
      flash.now[:danger] = '保存に失敗しました'
      render 'new'
    end
  end

  def edit
    @income = Income.find_by(id: params[:id])
  end
  
  def update
    @income = Income.find_by(id: params[:id])
    if @income.update_attributes(income_params)
      redirect_to index_url
    else
      render "edit"
    end
  end
  
  def destroy
    @income = Income.find_by(id: params[:id])
    @income.destroy
    redirect_to index_url
  end
  
  private
    def income_params
      params.require(:income).permit(:amount, :categories, :memo, :date, :user_id)
    end
end
