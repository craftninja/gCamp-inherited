class MembershipsController < ApplicationController
  before_action :set_project
  before_action :ensure_membership

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(allowed_params)
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was added successfully"
    else
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    @membership.update(allowed_params)
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path, notice: "#{membership.user.full_name} was removed successfully"
  end

  private

  def allowed_params
    params.require(:membership).permit(:user_id, :role,)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
