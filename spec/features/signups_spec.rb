require 'rails_helper'

feature "Sign Up" do

  scenario "User can sign up and then sign out" do
    visit root_path
    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")
    fill_in "First Name", with: "Mr."
    fill_in "Last Name", with: "Rogers"
    fill_in "Email", with: "bemyneighbor@example.com"
    fill_in "Password", with: "rogers"
    fill_in "Password Confirmation", with: "rogers"

    click_on "Sign up"

    expect(page).to have_content("Mr. Rogers")
    expect(page).to have_content("Sign Out")
    expect(page).to have_no_content("Sign In")

    click_on "Sign Out"

    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).to have_no_content("Mr. Rogers")
  end

  scenario "User cannot sign up without email/password" do
    visit root_path
    click_on "Sign Up"
    fill_in "First Name", with: "Mr."
    fill_in "Last Name", with: "Rogers"
    fill_in "Password", with: "rogers"
    fill_in "Password Confirmation", with: "rogers"
    click_on "Sign up"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_no_content("Sign Out")
  end

end
