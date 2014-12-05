require 'rails_helper'

feature 'Tasks' do

  scenario 'Logged in user can create a Task' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project

    sign_in(user, password)

    visit project_tasks_path(project)
    expect(page).to have_content("Tasks for #{project.name}")
    within('.breadcrumb') do
      expect(page).to have_content('Projects')
      expect(page).to have_content(project.name)
      expect(page).to have_content('Tasks')
    end
    click_on 'Create Task'
    expect(page).to have_content('New Task')
    fill_in 'Description', with: 'New Task Description'
    fill_in 'Due date', with: Date.today
    click_on 'Create Task'

    expect(page).to have_content('New Task Description')
    expect(page).to have_content('Task was successfully created.')
  end

  scenario 'User can see task show page' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    task = create_task(project)

    sign_in(user, password)

    visit project_tasks_path(project)
    expect(page).to_not have_link('Show')

    click_on task.description
    expect(page).to have_link('Edit')
    within('.page-header') do
      expect(page).to have_content(task.description)
    end
  end

  scenario 'User can edit and view complete and incomplete tasks' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    task = create_task(project)

    sign_in(user, password)

    visit project_tasks_path(project)
    expect(page).to have_content(task.description)
    click_on 'Edit'
    expect(page).to have_content('Editing task')
    check 'Complete'

    click_on 'Update Task'
    expect(page).to have_content(task.description)

    click_on 'Tasks'
    expect(page).to have_no_content(task.description)

    click_on 'All'
    expect(page).to have_content(task.description)
  end

  scenario 'User can delete a Task' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    task = create_task(project)

    sign_in(user, password)

    visit project_tasks_path(project)

    expect(page).to have_content(task.description)
    expect(page).to_not have_link('Destroy')
    find('.glyphicon').click

    expect(page).to have_no_content(task.description)
    expect(page).to have_content('Task was successfully destroyed.')
  end

  scenario 'User cannot create a Task without a description' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project

    sign_in(user, password)

    visit project_tasks_path(project)
    click_on 'Create Task'
    click_on 'Create Task'

    expect(page).to have_content("Description can't be blank")
  end

  scenario 'Each task on index has number of comments listed' do
    password = 'password'
    user = create_user(:password => password)

    project0 = create_project(:name => 'Zero Tasks')
    task0 = create_task(project0)

    project1 = create_project(:name => 'One Task')
    task1 = create_task(project1)
    comment1 = create_comment(task1)

    project3 = create_project
    task3 = create_task(project3)
    comment3a = create_comment(task3)
    comment3b = create_comment(task3)
    comment3c = create_comment(task3)

    sign_in(user, password)

    visit project_tasks_path(project0)
    within('.badge') do
      expect(page).to have_content(0)
    end

    visit project_tasks_path(project1)
    within('.badge') do
      expect(page).to have_content(1)
    end

    visit project_tasks_path(project3)
    within('.badge') do
      expect(page).to have_content(3)
    end
  end

  scenario 'User can see number of members on project index' do
    password = 'password'
    user1 = create_user(:password => password)
    user2 = create_user
    project = create_project
    membership = create_membership(project, user1)

    sign_in(user1, password)

    visit project_path(project)
    click_on '1 member'
    expect(page).to have_content("#{project.name}: Manage Members")
    create_membership(project, user2)
    visit project_path(project)
    expect(page).to have_content('2 members')
  end

end
