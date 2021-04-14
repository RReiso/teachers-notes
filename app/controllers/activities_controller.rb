class ActivitiesController < ApplicationController
	before_action :find_user_by_user_id,
	              only: %i[new edit create destroy update index] #in apllication_controller
	before_action :no_access, only: %i[show] #in apllication_controller
	before_action :request_login, only: %i[new edit] #in sessions_helper
	before_action :restrict_activities_access, only: %i[edit] #private
	before_action :find_activity_by_id, only: %i[edit update destroy] #private

	def index #users/nr/activities (user_activities_path(user))
		@activities = Activity.where(user_id: params[:user_id])
	end

	def new #users/nr/activities/new
		if !is_current_user
			no_access
		else
			@new_activity = Activity.new
		end
	end

	def create #after users/nr/activities/new
		if no_category_param_warning #private
			redirect_to new_user_activity_path(@user)
		else
			@user.activities.create(
				title: params[:activity][:title],
				description: params[:activity][:description],
				category: string_of_categories,
			)
			flash[:success] = 'Activity created!'
			redirect_to user_activities_path(@user)
		end
	end

	def show; end

	def edit; end

	def update
		if no_category_param_warning
			redirect_to edit_user_activity_path(@user, @activity)
		else
			@activity.update(
				title: params[:activity][:title],
				description: params[:activity][:description],
				category: string_of_categories, #private 
			)
			flash[:success] = 'Saved!'
			redirect_to user_activities_path(@user)
		end
	end

	def destroy
		@activity.destroy
		flash[:success] = 'Activity deleted!'
		redirect_to user_activities_path(@user)
	end

	def all_activities
		#if user checks popular or all, method in activity.rb:
		if @activities = Activity.get_all_activities(params[:popular], params[:all])
			return
		elsif params[:activity] != nil
			#if user checks other boxes:
			@activities =
				Activity.get_activities_list_by_activity_category(
					params[:activity][:category],
				) #(passing an array of checked categories), method in activity.rb
		else
			#if user checks no boxes
			@activities = Activity.all
		end
	end

	def update_heart_count #does not work if private
		activity = Activity.find(params[:id])

		new_heart_count = Activity.increase_heart_count(activity) #in activity.rb

		activity.update(heart_count: new_heart_count)
		hash = { heart_count: activity.heart_count }
		render json: hash
	end

	private

	def find_activity_by_id
		@activity = Activity.find_by_id(params[:id])
	end

	def string_of_categories #converting an array into a string with comma separated values
		params[:activity][:category].join(', ')
	end

	def restrict_activities_access #restrictions on activities/nr/edit
		find_activity_by_id
		no_access if @activity.nil? || !is_activity_author(@activity)
	end

	def no_category_param_warning
		if !params[:activity][:category].present?
			flash[:warning] = 'Choose a category!'
		end
	end
end
