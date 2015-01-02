class StaticPagesController < ApplicationController
  def home
    @user = User.new
    
    # Redirect back to main page if the user is logged in
    if logged_in?
      redirect_to current_user
    end

  end
  

  def about
  end

  def feed
    @status = current_user.statuses.build if logged_in?

    @statuses = Status.all.paginate(page: params[:page])
  end
end
