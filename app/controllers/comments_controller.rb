class CommentsController < ApplicationController
before_action :find_user_by_user_id, only: %i[index]#in application_controller
	before_action :find_activity_by_activity_id, only: %i[index]#private

  def index
    @comments = Comment.where(activity_id:params[:activity_id])
    @new_comment = Comment.new
  end
 

  private
  def find_activity_by_activity_id
    @activity = Activity.find(params[:activity_id])
  end
end
