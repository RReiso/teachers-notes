class UsersController < ApplicationController
  before_action :no_access, only: %i[edit index show] #in applications_controller
  before_action :logged_in_flash, only: [:new] #in sessions_helper.rb

  def index; end

  def new #signup path
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.name} to the Teacher's Pocket!"
      redirect_to :all_activities
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
end
