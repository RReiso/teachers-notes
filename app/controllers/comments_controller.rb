class CommentsController < ApplicationController
	before_action :no_access, only: %i[new show]#in sessions_helper
	before_action :restrict_comments_access, only: %i[edit]#in sessions_helper
	before_action :find_user_by_user_id, only: %i[index create edit destroy] #in application_controller
	before_action :find_activity_by_activity_id,
	              only: %i[index create edit destroy] #private
	before_action :find_comment_by_id, only: %i[edit] #private

	def index
		@comments = Comment.where(activity_id: params[:activity_id])
		@new_comment = Comment.new
	end

  def show
  end

  def new
  end

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

	def edit
    # render plain:params
  end
  
  def update
    render plain:params
    
  end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = 'Comment deleted!'
		redirect_to user_activity_comments_path(@user, @activity)
	end

	private

	def find_activity_by_activity_id
		@activity = Activity.find(params[:activity_id])
	end

	def find_comment_by_id
		@comment = Comment.find(params[:id])
	end
end
