class OutgosController < ApplicationController
  before_action :logged_in_user
  
  def home
    @outgos = current_user.outgos.paginate(page: params[:page]).order(date: "DESC")
  end

  def new
    @outgo = Outgo.new
  end
  
  def create
    @outgo = current_user.outgos.build(outgo_params)
    if @outgo.save
      redirect_to root_path
    else
      flash.now[:danger] = '保存に失敗しました'
      render 'new'
    end
  end
  
  def edit
    @outgo = Outgo.find_by(id: params[:id])
  end
  
  def update
    @outgo = Outgo.find_by(id: params[:id])
    if @outgo.update_attributes(outgo_params)
      redirect_to index_url
    else
      render "edit"
    end
    
  end
  
  def destroy
    @outgo = Outgo.find_by(id: params[:id])
    @outgo.destroy
    redirect_to index_url
  end
  
  
  private
    def outgo_params
      params.require(:outgo).permit(:amount, :categories, :memo, :date)
    end
end
