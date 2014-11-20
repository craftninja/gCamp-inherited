require 'rails_helper'

feature 'Memberships' do
  scenario 'User can create a membership' do
    password = 'password'
    user = User.create!(
      first_name: "Emily",
      last_name: "Platzer",
      email: 'emily@example.com',
      password: password
    )
    project1 = Project.create!(
      name: "Awesome Project"
    )
    visit project_memberships_path(project1)
    select user.full_name, from: 'membership_user_id'
    select "member", from: 'membership_role'
    click_on 'Add New Member'
    within ".table" do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content('member')
    end
  end

  scenario 'User can edit a membership' do
    password = 'password'
    user = User.create!(
      first_name: "Emily",
      last_name: "Platzer",
      email: 'emily@example.com',
      password: password
    )
    project = Project.create!(
      name: "Awesome Project"
    )
    membership = Membership.create!(
      user: user,
      project: project,
      role: :member
    )
    visit project_memberships_path(project)
    within ".table" do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(membership.role)
    end
  end

  scenario 'User can delete a membership' do
    password = 'password'
    user = User.create!(
      first_name: "Emily",
      last_name: "Platzer",
      email: 'emily@example.com',
      password: password
    )
    project = Project.create!(
      name: "Awesome Project"
    )
    membership = Membership.create!(
      user: user,
      project: project,
      role: :member
    )
    visit project_memberships_path(project)
    within '.table' do
      expect(page).to have_content(user.full_name)
    end
    find('.glyphicon').click
    within '.table' do
      expect(page).to_not have_content(user.full_name)
    end
  end

end
