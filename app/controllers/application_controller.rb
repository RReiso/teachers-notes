class ApplicationController < ActionController::Base
  include SessionsHelper # sessions_helper.rb

  def no_access
      flash[:danger] = "Forbidden"
      redirect_to :all_activities
    end

    def find_user_by_user_id
      if User.find_by_id(params[:user_id]).nil?
      no_access
      else
		@user = User.find_by_id(params[:user_id])
      end

      
	end

  
	
  


def get_user(activity)
  User.find(activity.user_id)
  
end
helper_method :get_user
    
end
