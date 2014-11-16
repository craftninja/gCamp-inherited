require 'rails_helper'

feature "Projects" do

  scenario "User can create a Project" do
    visit projects_path
    expect(page).to have_content("Projects")
    click_on "Create Project"
    fill_in "Name", with: "Build something!"
    click_on "Create Project"

    expect(page).to have_content("Build something!")
  end

  scenario "User can see a project" do
    Project.create!(
      name: "Build a boat"
    )

    visit projects_path
    click_on "Build a boat"
    expect(page).to have_content("Build a boat")
    expect(page).to have_content("Edit")
  end

  scenario "User can edit a project" do
    project = Project.create!(
      name: "End War"
    )

    visit project_path(project)
    expect(page).to have_content("End War")
    click_on "Edit"
    expect(page).to have_content("Edit Project")
    fill_in "Name", with: "Build a dog house"
    click_on "Update Project"
    expect(page).to have_no_content("End War")
    expect(page).to have_content("Build a dog house")
    expect(page).to have_content("Project was successfully updated")
  end

  scenario "User can delete a Project" do
    project = Project.create!(
      name: "Write a song"
    )

    visit project_path(project)
    expect(page).to have_content("Write a song")
    expect(page).to have_content("Destroy")
    click_on "Destroy"

    expect(page).to have_no_content("Write a song")
    expect(page).to have_content("Project was successfully deleted")
  end

  scenario "User cannot create a Project without a name" do
    visit projects_path
    click_on "Create Project"
    click_on "Create Project"

    expect(page).to have_content("Name can't be blank")
  end

  scenario "Project lists number of tasks, project tasks lists only project's tasks" do
    sweater_project = Project.create!(
      name: 'Make a sweater'
    )
    penannular_project = Project.create!(
      name: 'Make a penannular'
    )
    leather_project = Project.create!(
      name: 'Make a leather bag'
    )

    sweater_task_1 = Task.create!(
      project_id: sweater_project.id,
      description: 'Spin wool',
    )
    sweater_task_2 = Task.create!(
      project_id: sweater_project.id,
      description: 'Ply yarn',
    )
    sweater_task_3 = Task.create!(
      project_id: sweater_project.id,
      description: 'Knit sweater',
    )
    penannular_task = Task.create!(
      project_id: penannular_project.id,
      description: 'Cut wire'
    )

    visit project_path(sweater_project)
    expect(page).to have_content('3 tasks')

    visit project_path(penannular_project)
    expect(page).to have_content('1 task')

    visit project_path(leather_project)
    expect(page).to have_content('0 tasks')

    visit project_tasks_path(sweater_project)
    expect(page).to have_content('Make a sweater')
    expect(page).to have_content('Spin wool')
    expect(page).to have_content('Ply yarn')
    expect(page).to have_content('Knit sweater')
    expect(page).to_not have_content('Make a penannular')
    expect(page).to_not have_content('Cut wire')
  end

  scenario 'User can see list of projects tasks' do
    sweater_project = Project.create!(
      name: 'Make a sweater'
    )
    sweater_task_1 = Task.create!(
      project_id: sweater_project.id,
      description: 'Spin wool',
    )
    sweater_task_2 = Task.create!(
      project_id: sweater_project.id,
      description: 'Ply yarn',
    )
    sweater_task_3 = Task.create!(
      project_id: sweater_project.id,
      description: 'Knit sweater',
    )
    visit project_path(sweater_project)
    click_on "#{sweater_project.tasks.count} tasks"
    expect(page).to have_content('Make a sweater')
    expect(page).to have_content('Spin wool')
    expect(page).to have_content('Ply yarn')
    expect(page).to have_content('Knit sweater')
  end

end
