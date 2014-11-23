require 'rails_helper'

feature 'Comments' do

  scenario 'User can add comments to task show, commenter is linked to user show page' do
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
    within('.comments') do
      expect(page).to have_content('That sounds awesome')
      expect(page).to have_content('less than a minute')
      click_on user.full_name
    end
    expect(page).to have_content("First Name: #{user.first_name}")
    expect(page).to have_content("Last Name: #{user.last_name}")
    expect(page).to have_content("Email: #{user.email}")
  end

  scenario 'User not logged in cannot see comment form on task show page' do
    project = create_project
    task = create_task(project)

    visit project_task_path(project, task)
    expect(page).to have_content('Comment')
    expect(page).to_not have_selector('form')
    expect(page).to_not have_button('Add Comment')
  end

end
