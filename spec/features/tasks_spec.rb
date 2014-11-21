require 'rails_helper'

feature 'Tasks' do

  scenario 'User can create a Task' do
    project = create_project

    visit project_tasks_path(project)
    expect(page).to have_content("Tasks for #{project.name}")
    within('.breadcrumb') do
      expect(page).to have_content('Projects')
      expect(page).to have_content(project.name)
      expect(page).to have_content('Tasks')
    end
    click_on 'Create Task'
    expect(page).to have_content('New Task')
    fill_in 'Description', with: 'Extreme Testing!'
    fill_in 'Due date', with: Date.today
    click_on 'Create Task'

    expect(page).to have_content('Extreme Testing!')
    expect(page).to have_content('Task was successfully created.')
  end

  scenario 'User can see task show page' do
    project = create_project
    task = create_task(project)

    visit project_tasks_path(project)

    expect(page).to have_content(task.description)
    click_on 'Show'
    expect(page).to have_content(task.description)
  end

  scenario 'User can edit and view complete and incomplete tasks' do
    project = create_project
    task = create_task(project)

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
    project = create_project
    task = create_task(project)

    visit project_tasks_path(project)
    expect(page).to have_content(task.description)
    click_on 'Destroy'
    expect(page).to have_no_content(task.description)
  end

  scenario 'User cannot create a Task without a description' do
    project = create_project
    visit project_tasks_path(project)
    click_on 'Create Task'
    click_on 'Create Task'

    expect(page).to have_content("Description can't be blank")
  end

end
