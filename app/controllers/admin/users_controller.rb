class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :if_not_admin
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :logout_required
  before_action :destroy_if_only_one_admin, only: [:destroy]
  before_action :update_if_only_one_admin, only: [:update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: User.human_attribute_name(:user_created)
    else
      render :new
    end
  end

  def show
    @tasks = current_user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: User.human_attribute_name(:user_updated)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: User.human_attribute_name(:user_deleted)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def if_not_admin
    redirect_to tasks_path, notice: User.human_attribute_name(:admin_user) unless current_user.admin == "あり"
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def destroy_if_only_one_admin
    if User.where(admin: 'true').count == 1
      redirect_to admin_users_path, notice: User.human_attribute_name(:admin_destroy)
    end
  end

  def update_if_only_one_admin
    if User.where(admin: 'true').count == 1
      redirect_to admin_users_path, notice: User.human_attribute_name(:admin_update)
    end
  end
end
