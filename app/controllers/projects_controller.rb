class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :ensure_membership, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create(
        :project => @project,
        :user => current_user,
        :role => :owner
      )
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to project_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
      params.require(:project).permit(:name)
  end

  def ensure_membership
    unless @project.memberships.find_by(:user => current_user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
