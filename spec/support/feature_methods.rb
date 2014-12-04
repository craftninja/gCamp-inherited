def sign_in(user = create_user, password = 'password')
  visit root_path
  click_link ('Sign In')
  fill_in 'Email', with: user.email
  fill_in 'Password', with: password
  click_button('Sign in')
end
