require 'rails_helper'

feature 'Projects' do

  scenario 'User can create a Project' do
    visit projects_path
    expect(page).to have_content('Projects')
    click_on 'Create Project'
    fill_in 'Name', with: 'Build something!'
    click_on 'Create Project'

    expect(page).to have_content('Build something!')
  end

  scenario 'User can see a project' do
    project = create_project

    visit projects_path
    click_on project.name

    expect(page).to have_content(project.name)
    expect(page).to have_content('Edit')
  end

  scenario 'User can edit a project' do
    project = create_project
    new_proj_name = 'Explore new worlds'

    visit project_path(project)
    expect(page).to have_content(project.name)
    click_on 'Edit'
    expect(page).to have_content('Edit Project')
    fill_in 'Name', with: new_proj_name
    click_on 'Update Project'
    expect(page).to have_no_content(project.name)
    expect(page).to have_content(new_proj_name)
    expect(page).to have_content('Project was successfully updated')
  end

  scenario 'User can delete a Project' do
    project = create_project

    visit project_path(project)
    expect(page).to have_content(project.name)
    expect(page).to have_content('Destroy')
    click_on 'Destroy'

    expect(page).to have_no_content(project.name)
    expect(page).to have_content('Project was successfully deleted')
  end

  scenario 'User cannot create a Project without a name' do
    visit projects_path
    click_on 'Create Project'
    click_on 'Create Project'

    expect(page).to have_content("Name can't be blank")
  end

  scenario "Project lists number of tasks, project tasks lists only project's tasks" do
    project3 = create_project(name: 'Make a sweater')
    project1 = create_project(name: 'Make a penannular')
    project0 = create_project(name: 'Make a leather bag')

    p3_task_1 = create_task(
      project3,
      description: 'Spin wool',
    )
    p3_task_2 = create_task(
      project3,
      description: 'Ply yarn',
    )
    p3_task_3 = create_task(
      project3,
      description: 'Knit sweater',
    )
    p1_task = create_task(
      project1,
      description: 'Cut wire'
    )

    visit project_path(project3)
    expect(page).to have_content('3 tasks')

    visit project_path(project1)
    expect(page).to have_content('1 task')

    visit project_path(project0)
    expect(page).to have_content('0 tasks')

    visit project_tasks_path(project3)
    expect(page).to have_content(project3.name)
    expect(page).to have_content(p3_task_1.description)
    expect(page).to have_content(p3_task_2.description)
    expect(page).to have_content(p3_task_3.description)
    expect(page).to_not have_content(project1.name)
    expect(page).to_not have_content(p1_task.description)
  end

  scenario 'User can see list of projects tasks' do
    project = create_project

    task_1 = create_task(project)
    task_2 = create_task(project,
      description: 'Explore',
    )
    task_3 = create_task(project,
      description: 'Travel',
    )
    visit project_path(project)
    click_on "#{project.tasks.count} tasks"
    expect(page).to have_content(project.name)
    expect(page).to have_content(task_1.description)
    expect(page).to have_content(task_2.description)
    expect(page).to have_content(task_3.description)
  end

  scenario 'Projects index also lists number of members, tasks' do

    project00 = create_project
    visit projects_path
    within('tbody') do
      within first('tr') do
        expect(page).to have_content('0', :count => 2)
      end
    end
    project00.destroy

    project11 = create_project
    user1 = create_user
    create_task(project11)
    create_membership(project11, user1)
    visit projects_path
    within('tbody') do
      within first('tr') do
        expect(page).to have_content('1', :count => 2)
      end
    end
    project11.destroy

    project33 = create_project
    user2 = create_user(:email => 'email2@example.com')
    user3 = create_user(:email => 'email3@example.com')
    create_task(project33)
    create_task(project33, :description => 'another')
    create_task(project33, :description => 'and another')
    create_membership(project33, user1)
    create_membership(project33, user2)
    create_membership(project33, user3)
    visit projects_path
    within('tbody') do
      within first('tr') do
        expect(page).to have_content('3', :count => 2)
      end
    end
    project33.destroy
  end

end
