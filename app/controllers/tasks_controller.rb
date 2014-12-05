class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  before_action :ensure_membership

  def index
    @tasks = @project.tasks.where(complete: false).page(params[:page]).per(5)
    @ref = "incomplete"
    if params[:type] =="all"
      @tasks = @project.tasks.all.page(params[:page]).per(5)
      @ref = "all"
    end
  end

  def show
    @comment = Comment.new
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_url(@project), notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end

  def ensure_membership
    unless @project.memberships.find_by(:user => current_user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
