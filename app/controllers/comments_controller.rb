class CommentsController < ApplicationController
	before_action :no_access, only: %i[new show] #in sessions_helper
	before_action :restrict_comments_access, only: %i[edit] #private

	before_action :find_user_by_user_id,
	              only: %i[index create edit update destroy] #in application_controller
	before_action :find_activity_by_activity_id,
	              only: %i[index create edit update destroy] #private
	before_action :find_comment_by_id, only: %i[edit update destroy] #private

	def index
		if @activity.nil?
			no_access
		else
			@comments = Comment.where(activity_id: params[:activity_id])
			@new_comment = Comment.new
		end
	end

	def show; end

	def new; end

	def create
		@activity.comments.create(
			user: logged_in_user.name, #in sessions_helper
			body: params[:comment][:body],
		)
		redirect_to user_activity_comments_path(
				@user,
				@activity,
				anchor: 'comments',
		            )
	end

	def edit; end

	def update
		# render plain: params
		@comment.update(body: params[:comment][:body])
		flash[:success] = 'Saved!'
		redirect_to user_activity_comments_path(@user, @activity)
	end

	def destroy
		@comment.destroy
		flash[:success] = 'Comment deleted!'
		redirect_to user_activity_comments_path(@user, @activity)
	end

	private

	def find_activity_by_activity_id
		@activity = Activity.find_by_id(params[:activity_id])
	end

	def find_comment_by_id
		@comment = Comment.find_by_id(params[:id])
	end

	def restrict_comments_access #restrictions on comments/nr/edit
		find_comment_by_id
		find_activity_by_activity_id
		no_access if @activity.nil? || @comment.nil? || !is_comment_author(@comment)
	end
end
