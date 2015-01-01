class UsersController < ApplicationController
  
  # Run the private method logged_in_user on edit and update actions
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :delete

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])

    @statuses = @user.statuses.paginate(page: params[:page])

    @status = @current_user.statuses.build if logged_in?
    
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
    @user = User.find(params[:id])
    if @user.update_attributes(get_params)
      flash[:success] = "Profile updated!"
      redirect_to edit_user_url
    else
      flash.now[:danger] = "Invalid updates"
      render 'edit'
    end
    
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted!"
    redirect_to users_url
  end

  private

  def get_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Determine whether user is an admin
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
