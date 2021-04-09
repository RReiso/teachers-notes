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
  def logged_in_user
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
      if logged_in_user
        flash[:info] = "Already logged in!"
      redirect_to root_path
      end
    end

    def request_login
      if !logged_in_user
        flash[:warning] = "Please log in!"
      redirect_to login_path
      end
    
  end

  def is_activity_author(activity) #checks if the current logged in user is the author of the activity
     session[:user_id] == activity.user_id
  end

  def is_comment_author(comment) #checks if the current logged in user is the author of the comment
    user = User.find_by(name: comment.user )
     session[:user_id] == user.id
    
  end
  
def is_current_user #checks if the current logged in user is accesing their activities
  session[:user_id].to_s == params[:user_id] 
end

def restrict_activities_access
  activity = Activity.find_by_id(params[:id])
  if activity.nil? || !is_activity_author(activity) 
    no_access
  end
end

def restrict_comments_access
  comment = Comment.find_by_id(params[:id])
  if comment.nil? || !is_comment_author(comment) 
    no_access
  end
end

end
