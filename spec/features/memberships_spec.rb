require 'rails_helper'

feature 'Memberships' do

  scenario 'Logged in non-member does not have access to memberships' do
    password = 'password'
    user = create_user(:password => password)
    another_user = create_user
    project = create_project
    membership = create_membership(project, another_user)

    sign_in(user, password)

    visit project_memberships_path(project)
    expect(page).to have_content("The page you were looking for doesn't exist")

    visit project_memberships_path(project, membership)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario 'Logged in member can create a new membership' do
    password = 'password'
    user = create_user(:password => password)
    another_user = create_user
    project = create_project
    create_membership(project, user)

    sign_in(user, password)

    visit project_memberships_path(project)
    within '.well' do
      select another_user.full_name, from: 'membership_user_id'
      select 'member', from: 'membership_role'
      click_on 'Add New Member'
    end

    expect(page).to have_content("#{another_user.full_name} was added successfully")
    within '.table' do
      expect(page).to have_content(another_user.full_name)
      expect(page).to have_content('member')
    end
  end

  scenario 'Logged in user can edit a membership' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    membership = create_membership(project, user)
    new_role = 'owner'

    sign_in(user, password)

    visit project_memberships_path(project)
    within '.table' do
      select new_role, from: 'membership_role'
      click_on 'Update'
    end

    expect(page).to have_content("#{user.full_name} was updated successfully")
    within '.table' do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(new_role)
    end
  end

  scenario 'Logged in member can delete a membership' do
    password = 'password'
    user = create_user(:password => password)
    another_user = create_user
    project = create_project

    #this order matters to click the correct glyphicon below
    another_membership = create_membership(project, another_user)
    membership = create_membership(project, user)

    sign_in(user, password)

    visit project_memberships_path(project)

    within '.table' do
      expect(page).to have_content(another_user.full_name)
    end

    first('.glyphicon').click
    expect(page).to have_content("#{another_user.full_name} was removed successfully")
    within '.table' do
      expect(page).to_not have_content(another_user.full_name)
    end
  end

end
