class UsersController < ApplicationController
  before_action :no_access, only: [:edit, :index, :show]

  def index
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if !current_user_method
      @user = User.new
      render "new"
    else
      flash[:info] = "Already logged in!"
      redirect_to root_path
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.name} to the Teacher's Pocket!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def no_access
      flash[:danger] = "Forbidden"
      redirect_to root_path
    end
end
