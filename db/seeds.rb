# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    { first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.safe_email("#{first_name} #{last_name}"),
    password: "#{first_name}password",
    password_confirmation: "#{first_name}password" }
  )
end

3.times do
  project = Project.create(
    name: "#{Faker::Hacker.noun.capitalize} Project",
  )
  6.times do
    Task.create(
      description: "#{Faker::Hacker.verb.capitalize} #{project.name}",
      due_date: Faker::Time.forward(23),
      complete: [false, false, false, true].sample,
      project_id: project.id
    )
  end
  4.times do
    Membership.create(
      project_id: project.id,
      user_id: User.all.sample.id,
      role: [0,0,0,1].sample
    )
  end
end
