class ApplicationController < ActionController::Base
  include SessionsHelper # sessions_helper.rb

  def no_access
      flash[:danger] = "Forbidden"
      redirect_to :all_activities
    end

    
end
