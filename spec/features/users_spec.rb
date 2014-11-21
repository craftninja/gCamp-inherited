require 'rails_helper'

feature 'Users' do

  scenario 'User can create a user' do
    visit users_path
    expect(page).to have_content('Users')
    click_on 'Create User'
    expect(page).to have_content('New User')
    fill_in 'First Name', with: 'Thomas'
    fill_in 'Last Name', with: 'Iliffe'
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_on 'Create User'

    expect(page).to have_content('Thomas Iliffe')
  end

  scenario 'User can edit a user' do
    user = create_user

    visit users_path
    expect(page).to have_content(user.first_name)
    click_on 'Edit'
    fill_in 'First Name', with: 'E. O.'
    fill_in 'Last Name', with: 'Wilson'
    fill_in 'Email', with: 'biophilia@example.com'
    click_on 'Update User'

    expect(page).to have_content('E. O. Wilson')
    expect(page).to have_no_content(user.first_name)
  end

  scenario 'User can see users show page' do
    user = create_user

    visit users_path
    click_on user.full_name

    expect(page).to have_content(user.first_name)
  end

  scenario 'User can delete a user' do
    user = create_user

    visit users_path
    expect(page).to have_content(user.full_name)
    click_on 'Edit'
    click_on 'Delete User'
    expect(page).to have_no_content(user.full_name)
  end

end
