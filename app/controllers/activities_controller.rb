class ActivitiesController < ApplicationController
before_action :require_current_user, only: [:new, :edit] #(in sessions_helper)
before_action :find_user_by_id, only: [:new, :edit, :create, :destroy, :update] #private


  def index #users/nr/activities
    render plain: params
   end 

  def new #users/nr/activities/new
    @new_activity = Activity.new
    
  end
  
  def create
    render plain: params
  end

  def edit
  end

  def all_activities
if params[:popular] == "yes" #if user checks "popular"
  #organize all activities into descending order according to heart_count:
   @activities = Activity.order(heart_count: :desc)

elsif params[:all] == "yes" #if user checks "all"
  @activities = Activity.all 

elsif params[:activity] != nil  #if user checks other boxes
  @activities = [] #store filtered results
      categories= params[:activity][:categories] #array of checked categories
      categories.each do |c|
        activity = Activity.all.where("category like ?", "%#{c}%")
        if activity != [] #"if activity" doesn't work because "where" returns empty record []
          @activities << activity
          @activities.flatten! #from[1,2,[3,4]] to [1,2,3,4]
          @activities = @activities.uniq #delete duplicates
        end
      end

    else #if user checks no boxes
        @activities = Activity.all 
    end          

    
end
 private
 def find_user_by_id
  @user = User.find(params[:user_id])
 end


end
