class SessionsController < ApplicationController
  add_breadcrumb "Home", :articles_path
  
  def new
    add_breadcrumb "Log In", login_path
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in, remember their token and direct to user profile page
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else 
      # Create new render on login page and throw error
      flash.now[:danger] = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You\'ve logged out successfully.'
    redirect_to articles_path
  end

end
