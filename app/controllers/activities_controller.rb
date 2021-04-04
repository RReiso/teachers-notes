class ActivitiesController < ApplicationController
before_action :require_current_user, only: [:new, :edit] #(in sessions_helper)


  def index #users/nr/activities
    render plain: params
   end 

  def new #users/nr/activities/new
    render plain: params 
  end

  def edit
  end

  def all_activities
   @all_activities = Activity.all 
   @p = params
  end

  def category
    render plain: params
  end

  
end
