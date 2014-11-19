class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(allowed_params)
    if @membership.save
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
    @membership.update(allowed_params)
    if @membership.save
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path
  end

  private

  def allowed_params
    params.require(:membership).permit(:user_id, :role,)
  end
end
