class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :logout_required
  before_action :correct_user, only: [:show, :edit]

  def index
    @tasks = @current_user.tasks

    # 終了期限/優先度ソート機能
    if params[:sort_deadline_on]
      @tasks = @tasks.sort_deadline_on
    elsif params[:sort_priority]
      @tasks = @tasks.sort_priority
    end

    # 検索機能
    if params[:search].present?
      @tasks = @tasks
        .search_status(params[:search][:status])
        .search_title(params[:search][:title])
        .search_label(params[:search][:label_id])
    end

    # ページネーション
    @tasks = @tasks.page(params[:page]).default_order
    # 下記はmodelへ記載
    # if params[:search].present?
    #   if params[:search][:status].present? && params[:search][:title].present?
    #     @tasks = @tasks.search_status(params[:search][:status]).search_title(params[:search][:title])
    #   elsif params[:search][:status].present?
    #     @tasks = @tasks.search_status(params[:search][:status])
    #   elsif params[:search][:title].present?
    #     @tasks = @tasks.search_title(params[:search][:title])
    #   end 
    # end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      # @label = LabelTask.new(label_id: params[:task][:label_ids].first, task_id: @task.id)
      @task.labels.push(Label.find(params[:task][:label_ids]))
      redirect_to tasks_path, notice: Task.human_attribute_name(:task_created)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      if params[:task][:label_ids].present?
        @task.labels.push(Label.find(params[:task][:label_ids]))
      else
        @task.labels.destroy
      end
      redirect_to tasks_path, notice: Task.human_attribute_name(:task_updated)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: Task.human_attribute_name(:task_destroyed)
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, :label_ids)
    end

    def correct_user
      user_id = Task.find(params[:id]).user_id
      redirect_to tasks_path, notice: User.human_attribute_name(:correct_user)  unless current_user?(user_id)
    end
end
