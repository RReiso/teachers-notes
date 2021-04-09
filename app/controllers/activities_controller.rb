class ActivitiesController < ApplicationController
	#(in sessions_helper):
	before_action :no_access, only: %i[show] #%i - syntax??? I think VS extension is doing this
	before_action :request_login, only: %i[new edit] #%i - syntax??? I think VS extension is doing this
	before_action :restrict_unauthorized_access, only: %i[new edit]

	#private:
	before_action :find_user_by_user_id, only: %i[new edit create destroy update index] #in apllication_controller
	before_action :find_activity_by_id, only: %i[edit update destroy]#private

	def index #users/nr/activities (user_activities_path(user))
		@activities = Activity.where(user_id: params[:user_id])
	end

	def new #users/nr/activities/new
		@new_activity = Activity.new
	end

	def create #after users/nr/activities/new
		@user.activities.create(
			title: params[:activity][:title],
			description: params[:activity][:description],
			category: string_of_categories,
		)
		flash[:success] = 'Activity created!'
		redirect_to user_activities_path(@user)
	end

def show
  
end

	def edit; end

	def update
		@activity.update(
			title: params[:activity][:title],
			description: params[:activity][:description],
			category: string_of_categories, #private method
		)
		flash[:success] = 'Saved!'
		redirect_to user_activities_path(@user)
	end

	def destroy
		@activity.destroy
		flash[:success] = 'Activity deleted!'
		redirect_to user_activities_path(@user)
	end

	def all_activities
		if params[:popular] == 'yes'
			#if user checks "popular"
			#organize all activities into descending order according to heart_count:
			@activities = Activity.order(heart_count: :desc)
		elsif params[:all] == 'yes'
			#if user checks "all"
			@activities = Activity.all
		elsif params[:activity] != nil
			#if user checks other boxes
			@activities = [] #store filtered results
			categories = params[:activity][:category] #array of checked categories
			categories.each do |c|
				activity = Activity.all.where('category like ?', "%#{c}%")
				if activity != []
					#"if activity" doesn't work because "where" returns empty record []
					@activities << activity
					@activities.flatten! #from[1,2,[3,4]] to [1,2,3,4]
					@activities = @activities.uniq #delete duplicates
				end
			end
		else
			#if user checks no boxes
			@activities = Activity.all
		end
	end

  def update_heart_count
    activity = Activity.find(params[:id])
    
    if !activity.heart_count
      new_heart_count = 1
    else  
      new_heart_count = activity.heart_count + 1
    end  
    activity.update(heart_count: new_heart_count)
    hash = {heart_count: activity.heart_count}
    render json: hash
  end

	private

	def find_activity_by_id
		@activity = Activity.find(params[:id])
	end

  def string_of_categories #converting an array into a string with comma separated values
    params[:activity][:category].join(', ')
  end
end
