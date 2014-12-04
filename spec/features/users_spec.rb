require 'rails_helper'

feature 'Users' do

  scenario 'Logged in user can create a user' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')
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

  scenario 'Logged in user can edit a user' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')
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

  scenario 'Logged in user can see users show page' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')
    visit users_path
    within '.table' do
      click_on user.full_name
    end

    expect(page).to have_content(user.first_name)
  end

  scenario 'Logged in user can delete a user' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')
    visit users_path
    expect(page).to have_content(user.full_name)
    click_on 'Edit'
    click_on 'Delete User'
    expect(page).to have_no_content(user.full_name)
  end

end
