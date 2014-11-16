require 'rails_helper'

feature "Users" do

  scenario "User can create a user" do
    visit users_path
    expect(page).to have_content("Users")
    click_on "Create User"
    expect(page).to have_content("New User")
    fill_in "First Name", with: "Extreme"
    fill_in "Last Name", with: "smith"
    fill_in "Email", with: "smith@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password Confirmation", with: "pass"
    click_on "Create User"

    expect(page).to have_content("Extreme")
  end

  scenario "User can edit a user" do
    user = User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content(user.first_name)
    click_on "Edit"
    fill_in "First Name", with: "Frank"
    fill_in "Last Name", with: "Sinatra"
    fill_in "Email", with: "blueeyes@example.com"
    click_on "Update User"

    expect(page).to have_content("Frank")
    expect(page).to have_no_content(user.first_name)
  end

  scenario "User can see users show page" do
    user = User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content(user.full_name)
    click_on "Mr. T"

    expect(page).to have_content(user.first_name)
    expect(page).to have_no_content("Password")
  end

  scenario "User can delete a user" do
    user = User.create!(
      first_name: "Mr. T" , last_name: "Pity the fool!" , email: "mrt@example.com",
      password: "pass", password_confirmation: "pass"
    )

    visit users_path
    expect(page).to have_content(user.full_name)
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content(user.full_name)
  end

end
