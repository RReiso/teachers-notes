class HomeController < ApplicationController
  def index; end

  def search
    if params[:search].blank?
      flash[:warning] = "Empty search field!"
      redirect_to :all_activities
      # redirect_to(root_path, alert: "Empty search field!") and return
    else
      @parameter = params[:search].downcase
      # @results = Activity.all.where("lower(description) LIKE :search", search: "%#{@parameter}%")
      # description - column name, Activity - activities in table
    end
  end

end
