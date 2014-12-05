require 'rails_helper'

feature 'Projects' do

  scenario 'Logged in user can create a Project, are added as project owner, redirected to tasks index' do
    password = 'password'
    user = create_user(:password => password)

    sign_in(user, password)

    click_on 'gCamp'
    expect(page).to have_content('Projects')
    click_on 'Create Project'
    fill_in 'Name', with: 'Build something!'
    click_on 'Create Project'

    expect(page).to have_content('Tasks for Build something!')

    click_on 'Build something!'
    expect(page).to have_content('1 membership')
    click_on '1 membership'

    within '.table' do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content('owner')
    end
  end

  scenario 'Logged in user can see a project, lists number of assoc. memberships & tasks' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    create_task(project)
    create_task(project)
    create_task(project)
    create_task(project)
    create_membership(project, user)

    sign_in(user, password)

    visit projects_path
    click_on project.name

    expect(page).to have_content(project.name)
    expect(page).to have_content('Edit')
    expect(page).to have_content('Delete')
    expect(page).to have_content("Deleting this project will also delete 1 membership, 4 tasks and associated comments")
  end

  scenario 'Logged in user can only see projects they are members of' do
    user = create_user
    project = create_project
    membership = create_membership(project, user)
    other_project = create_project

    sign_in(user)

    expect(page).to have_content(project.name)
    expect(page).to_not have_content(other_project.name)

    visit project_path(other_project)
    expect(page).to_not have_content(other_project.name)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario 'Logged in user can edit a project' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    create_membership(project, user)
    new_proj_name = 'New Project Name'

    sign_in(user, password)

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

  scenario 'Logged in user can delete a Project' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    create_membership(project, user)

    sign_in(user, password)

    visit project_path(project)
    expect(page).to have_content(project.name)
    within('.well') do
      click_on 'Delete'
    end

    expect(page).to have_no_content(project.name)
    expect(page).to have_content('Project was successfully deleted')
  end

  scenario 'Logged in user cannot create a Project without a name' do
    password = 'password'
    user = create_user(:password => password)

    sign_in(user, password)

    visit projects_path
    click_on 'Create Project'
    click_on 'Create Project'

    expect(page).to have_content("Name can't be blank")
  end

  scenario "Project lists number of tasks, project tasks lists only project's tasks" do
    password = 'password'
    user = create_user(:password => password)

    project3 = create_project
    create_membership(project3, user)
    project1 = create_project
    create_membership(project1, user)
    project0 = create_project
    create_membership(project0, user)

    p3_task_1 = create_task(project3)
    p3_task_2 = create_task(project3)
    p3_task_3 = create_task(project3)

    p1_task = create_task(project1)

    sign_in(user, password)

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

  scenario 'Logged in user can see list of projects tasks' do
    password = 'password'
    user = create_user(:password => password)

    project = create_project
    create_membership(project, user)
    task_1 = create_task(project)
    task_2 = create_task(project)
    task_3 = create_task(project)

    sign_in(user, password)

    visit project_path(project)
    click_on "#{project.tasks.count} tasks"
    expect(page).to have_content(project.name)
    expect(page).to have_content(task_1.description)
    expect(page).to have_content(task_2.description)
    expect(page).to have_content(task_3.description)
  end

  scenario 'Projects index also lists number of members, tasks' do
    password = 'password'
    user1 = create_user(:password => password)
    project1 = create_project
    create_membership(project1, user1)
    create_task(project1)

    sign_in(user1, password)

    visit projects_path
    within('tbody') do
      within first('tr') do
        expect(page).to have_content('1', :minimum => 2)
      end
    end
    project1.destroy

    project3 = create_project
    user2 = create_user
    user3 = create_user
    create_task(project3)
    create_task(project3)
    create_task(project3)
    create_membership(project3, user1)
    create_membership(project3, user2)
    create_membership(project3, user3)
    visit projects_path
    within('tbody') do
      within first('tr') do
        expect(page).to have_content('3', :minimum => 2)
      end
    end
    project3.destroy
  end

end
