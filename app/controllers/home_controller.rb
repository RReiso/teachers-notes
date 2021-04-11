class HomeController < ApplicationController
  def index; end

  def search
    if params[:search].blank?
      flash[:warning] = 'Empty search field!'
      redirect_to :all_activities and return #why "and return"?
    else
      @parameter = params[:search].downcase
      @results =
        Activity.all.where(
          'lower(description) LIKE :search or lower(title) LIKE :search or lower(category) LIKE :search',
          search: "%#{@parameter}%"
        )
    end
  end
end
