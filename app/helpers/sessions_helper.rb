module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

# User.find_by(id: session[:user_id])
# Rather than raising an exception (like .find), find_by method returns nil (indicating no such user) if the id is invalid.

# def current_user
#   User.find_by(id: session[:user_id])
# end
# This would work fine, but it would hit the database multiple times if, e.g., current_user appeared multiple times on a page. Instead, follow Ruby convention by storing the result of User.find_by in an instance variable, which hits the database the first time but returns the instance variable immediately on subsequent invocations:
  def current_user_method
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end
  #shorter: @current_user = @current_user || User.find_by(id: session[:user_id])
  #or: @current_user ||= User.find_by(id: session[:user_id])


  def log_out
    session.delete(:user_id) #session.clear?, reset_session?
    @current_user = nil
  end

  #Inform user if trying to access login/signup path while already logged in:
def logged_in_flash
      if current_user_method
        flash[:info] = "Already logged in!"
      redirect_to root_path
      end
    end

    def request_login
      if !current_user_method
        flash[:warning] = "Please log in!"
      redirect_to login_path
      end
    
  end

  def is_author(activity) #checks if the current logged in user is the author of the activity
     session[:user_id] == activity.user_id
  end
  
def is_current_user #checks if the current logged in user is accesing his own content
  session[:user_id].to_s == params[:user_id] 
end

def restrict_unauthorized_access
  if !is_current_user #if user tries to access "activities/new" or "activities/nr/edit" of another user:
          no_access #(in application_controller)
        end
end
end
