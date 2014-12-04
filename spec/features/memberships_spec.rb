require 'rails_helper'

feature 'Memberships' do
  scenario 'Logged in user can create a membership' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project

    sign_in(user, password)

    visit project_memberships_path(project)
    select user.full_name, from: 'membership_user_id'
    select 'member', from: 'membership_role'
    click_on 'Add New Member'

    expect(page).to have_content("#{user.full_name} was added successfully")
    within '.table' do
      expect(page).to have_content(user.full_name)
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

  scenario 'Logged in user can delete a membership' do
    password = 'password'
    user = create_user(:password => password)
    project = create_project
    membership = create_membership(project, user)

    sign_in(user, password)

    visit project_memberships_path(project)

    within '.table' do
      expect(page).to have_content(user.full_name)
    end
    find('.glyphicon').click
    expect(page).to have_content("#{user.full_name} was removed successfully")
    within '.table' do
      expect(page).to_not have_content(user.full_name)
    end
  end

end
