class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :correct_user, only: [:show]
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :logout_required, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to tasks_path, notice: User.human_attribute_name(:account_created)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: User.human_attribute_name(:account_updated)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def correct_user
    user_id = User.find(params[:id]).id
    redirect_to tasks_path, notice: User.human_attribute_name(:correct_user) unless current_user?(user_id)
  end
end
