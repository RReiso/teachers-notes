class ActivitiesController < ApplicationController
before_action :logged_in_user, only: [:new, :edit] #(in sessions_helper)

  def index #users/nr/activities
    render plain: params
   end 

  def new #users/nr/activities/new
    render plain: params 
  end

  def all_activities
   render plain: params 
  end

  def liked
    render plain: params
  end
end
