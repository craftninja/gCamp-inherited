require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe Task do

  it 'validates presence of description, due date must not be in past' do
    task = Task.new
    expect(task.valid?).to be(false)
    task.description = 'test'
    expect(task.valid?).to be(true)
    task.due_date = Date.today-7
    expect(task.valid?).to be(false)
    task.due_date = Date.today+7
    expect(task.valid?).to be(true)
  end

  it 'validates that past-due task descriptions can be updated' do
    project = create_project
    task = Task.new
    travel_to(1.day.ago) do
      task.description = 'old description'
      task.due_date = Date.today
      task.project_id = project.id
      expect(task.valid?).to be(true)
      task.save
    end
    travel_back
    task.description = 'new description'
    expect(task.valid?).to be(true)
  end

  it 'verifies that deletion of task also deletes associated comments' do
    project = create_project
    task = create_task(project)
    comment1 = create_comment(task)

    expect(Project.where(:id => project.id).any?).to be(true)
    expect(Task.where(:project_id => project.id).any?).to be(true)
    expect(Comment.where(:task_id => task.id).any?).to be(true)

    task.destroy

    expect(Project.where(:id => project.id).any?).to be(true)
    expect(Task.where(:project_id => project.id).any?).to be(false)
    expect(Comment.where(:task_id => task.id).any?).to be(false)
  end

end
