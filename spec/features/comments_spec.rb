require 'rails_helper'

feature 'Comments' do

  scenario 'User can add comments to a task show page' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    task = create_task(project)

    visit root_path
    expect(page).to have_content('gCamp')
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')

    visit project_task_path(project, task)
    fill_in 'comment[content]', :with => 'That sounds awesome'
    click_on 'Add Comment'
    expect(page).to have_content('That sounds awesome')
  end

end
