class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to articles_path
      end
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
