require 'rails_helper'

describe 'Projects' do
  it 'Deletes a projects associated tasks, memberships upon project destroy' do
    project = create_project
    user = create_user
    membership = create_membership(project, user)
    task = create_task(project)

    expect(Project.where(:id => project.id).any?).to be(true)
    expect(Membership.where(:project_id => project.id).any?).to be(true)
    expect(Task.where(:project_id => project.id).any?).to be(true)

    project.destroy

    expect(Project.where(:id => project.id).any?).to be(false)
    expect(Membership.where(:project_id => project.id).any?).to be(false)
    expect(Task.where(:project_id => project.id).any?).to be(false)
  end
end
