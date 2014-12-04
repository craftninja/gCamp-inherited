require 'rails_helper'

feature 'Memberships' do
  scenario 'User can create a membership' do
    user = create_user
    project = create_project

    visit project_memberships_path(project)
    select user.full_name, from: 'membership_user_id'
    select 'member', from: 'membership_role'
    click_on 'Add New Member'

    within '.table' do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content('member')
    end
  end

  scenario 'User can edit a membership' do
    user = create_user
    project = create_project
    membership = create_membership(project, user)
    new_role = 'owner'

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

  scenario 'User can delete a membership' do
    user = create_user
    project = create_project
    membership = create_membership(project, user)

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
