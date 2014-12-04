require 'rails_helper'

feature 'Sign in' do

  scenario 'User can sign in, sees My Projects link in navbar' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    expect(page).to have_content('gCamp')
    click_link ('Sign In')
    expect(page).to have_content('Sign into gCamp')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')

    expect(page).to have_content(user.full_name)
    expect(page).to have_link('Create Project')
    expect(page).to have_content('Sign Out')
    expect(page).to have_no_content('Sign In')
    within '.navbar' do
      expect(page).to have_content('My Projects')
    end
  end

  scenario 'User cannot sign in with invalid email' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: "wrong#{user.email}"
    fill_in 'Password', with: password
    click_button('Sign in')

    expect(page).to have_content('Username / password combination is invalid')
    expect(page).to have_content('Sign In')
    expect(page).to have_no_content('Sign Out')
  end

  scenario 'User wants to sign in with invalid data - password is wrong' do
    password = 'password'
    user = create_user(:password => password)

    visit root_path
    click_link ('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "wrong#{password}"
    click_button('Sign in')

    expect(page).to have_content('Username / password combination is invalid')
    expect(page).to have_content('Sign In')
    expect(page).to have_no_content('Sign Out')
  end

end
