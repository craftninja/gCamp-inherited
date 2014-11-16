require 'rails_helper'

feature "Projects" do

  scenario "User creates a Project" do

    visit projects_path
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")


    fill_in "Name", with: "Build something!"
    click_on "Create Project"

    expect(page).to have_content("Build something!")

  end

  scenario "User wants to see a project" do

    Project.create!(
      name: "Build a boat"
    )

      visit projects_path
      expect(page).to have_content("Build a boat")
      click_on "Build a boat"
      expect(page).to have_content("Build a boat")
      expect(page).to have_content("Edit")
      expect(page).to have_no_content("test")

  end

  scenario "User wants to edit a project" do

    Project.create!(
      name: "End War"
    )

      visit projects_path
      expect(page).to have_content("End War")
      click_on "End War"
      expect(page).to have_content("End War")
      expect(page).to have_no_content("test")
      click_on "Edit"
      expect(page).to have_content("Edit Project")
      fill_in "Name", with: "Build a dog house"
      click_on "Update Project"
      expect(page).to have_no_content("End War")
      expect(page).to have_content("Build a dog house")
      expect(page).to have_content("Project was successfully updated")

  end

  scenario "User wants to delete a Project" do

    Project.create!(
      name: "Write a song"
    )

    visit projects_path
    expect(page).to have_content("Write a song")
    click_on "Write a song"
    expect(page).to have_content("Destroy")
    click_on "Destroy"
    expect(page).to have_no_content("Write a song")
    expect(page).to have_content("Project was successfully deleted")

  end

  scenario "User want to create a Project w/o a name" do

    visit projects_path
    expect(page).to have_content("Projects")

    click_on "Create Project"
    expect(page).to have_content("Create Project")



    click_on "Create Project"

    expect(page).to have_content("Name can't be blank")

  end

  scenario "Project only lists project's tasks" do
    sweater_project = Project.create!(
      name: 'Make a sweater'
    )
    penannular_project = Project.create!(
      name: 'Make a penannular'
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

    visit project_tasks_path(sweater_project)
      expect(page).to have_content('Make a sweater')
      expect(page).to have_content('Spin wool')
      expect(page).to have_content('Ply yarn')
      expect(page).to have_content('Knit sweater')
      expect(page).to_not have_content('Make a penannular')
      expect(page).to_not have_content('Cut wire')
  end


end
