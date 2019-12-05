class UsersController < ApplicationController
  before_action :logged_in_user, only: [:home]
  
  def home
  end
  
  def index
    #keyが日付,valueが合計金額のハッシュ
    @incomes = current_user.incomes.order("DATE(date)").group("DATE(DATE)").sum(:amount)
    @outgos = current_user.outgos.order("DATE(date)").group("DATE(DATE)").sum(:amount)
  end

  def new
    @user = User.new
    redirect_to index_url if logged_in?
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to index_url
    else
      flash.now[:danger] = "作成に失敗しました"
      render "users/new"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation)
    end
end
