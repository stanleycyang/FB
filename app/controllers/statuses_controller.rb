class StatusesController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @statuses = User.find(params[:user_id]).statuses
  end

  def show
    @status = User.find(params[:user_id]).statuses.find_by(id: params[:id])
  end

  def create 
    @status = current_user.statuses.build(status_params)
    if @status.save
      flash[:success] = "Status created!"
      redirect_back_or home_url
    else
      flash[:danger] = "Invalid status!"
      redirect_back_or home_url
    end
    
  end

  def edit    
    # @status = User.find(params[:user_id]).statuses.find_by(params[:id])
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    # @status = User.find(params[:user_id]).statuses.find_by(params[:id])

    if @status.update_attributes(status_params)
      flash[:success] = "Successful edit!"
      redirect_to current_user
    else
      flash[:danger] ="Edit failed!"
      redirect_to current_user
    end
  end

  

  def destroy
    @status.destroy
    flash[:success] = "Status deleted"
    redirect_to request.referrer || root_url
  end

  private

  def status_params
    params.require(:status).permit(:content, :picture)
  end

  def correct_user
    @status = current_user.statuses.find_by(id: params[:id])
    redirect_to root_url if @status.nil?
  end
  
end
