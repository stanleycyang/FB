class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_params)   
    if @user.save 
      log_in(@user)
      flash.now[:success] = "Welcome to Facebook!"
      redirect_to @user
    else
      flash.now[:danger] = "Invalid sign up!"
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def get_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
