require 'rails_helper'

feature 'Comments' do

  scenario 'Logged in user can add comments to task show, commenter is linked to user show page' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    create_membership(project, user)
    task = create_task(project)

    sign_in(user, password)

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

  scenario 'Comment without content is not saved, and has no validation message' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    create_membership(project, user)
    task = create_task(project)

    sign_in(user, password)


    visit project_task_path(project, task)
    click_on 'Add Comment'
    within('.comments') do
      expect(page).to_not have_link(user.full_name)
      expect(page).to_not have_content('less than a minute')
    end
  end

end
