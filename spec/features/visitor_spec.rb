require 'rails_helper'

feature 'Visitor experience' do

  scenario 'Non-logged in user cannot access projects, tasks, memberships, users' do
    project = create_project

    visit projects_path
    expect(page).to have_content('You must be logged in to access that action')

    visit project_tasks_path(project)
    expect(page).to have_content('You must be logged in to access that action')

    visit project_memberships_path(project)
    expect(page).to have_content('You must be logged in to access that action')

    visit users_path
    expect(page).to have_content('You must be logged in to access that action')
  end

end
