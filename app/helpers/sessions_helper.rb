module SessionsHelper

    # Logs in the user
    def log_in(user)
        session[:user_id] = user.id
    end

    # If there is a logged in user, return it
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # If user logged in return true, else false
    def logged_in?
        !current_user.nil?
    end

    # Logs out the user
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end


end
