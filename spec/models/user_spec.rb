require 'rails_helper'


describe User do

  it 'validates presence of first name, last name, email, password' do
    user = User.new
    expect(user.valid?).to be(false)
    user.first_name = 'Barbara'
    expect(user.valid?).to be(false)
    user.last_name='Walker'
    expect(user.valid?).to be(false)
    user.email='barbara@example.com'
    expect(user.valid?).to be(false)
    user.password='password'
    expect(user.valid?).to be(true)
  end

  it 'validates uniqueness of email' do
    previous_user = create_user(:email => 'email@example.com')
    user = User.new(
      :first_name => 'Susun',
      :last_name => 'Weed',
      :password => 'password',
    )
    user.email = 'email@example.com'
    expect(user.valid?).to be(false)
    user.email = 'susun@example.com'
    expect(user.valid?).to be(true)
  end

end
