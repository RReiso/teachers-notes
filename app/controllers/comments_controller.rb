class CommentsController < ApplicationController
  before_action :no_access, only: %i[show]
before_action :find_user_by_user_id, only: %i[index create edit destroy]#in application_controller
	before_action :find_activity_by_activity_id, only: %i[index create edit destroy]#private
	before_action :find_comment_by_id, only: %i[edit]#private

  def index
    @comments = Comment.where(activity_id: params[:activity_id])
    @new_comment = Comment.new
  end

  def create
    @activity.comments.create(user: logged_in_user.name, body: params[:comment][:body])
    redirect_to user_activity_comments_path(@user, @activity, anchor: 'comments')
  end
 
  def edit

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
