class ApplicationController < ActionController::Base
  include SessionsHelper # sessions_helper.rb

  def no_access
      flash[:danger] = "Forbidden"
      redirect_to :all_activities
    end


def get_user(activity)
  User.find(activity.user_id)
  
end
helper_method :get_user
    
end
