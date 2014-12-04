User.delete_all
Project.delete_all
Task.delete_all
Comment.delete_all
Membership.delete_all

admin = User.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@example.com',
  password: 'password'
)

owner = User.create!(
  first_name: 'Owner',
  last_name: 'User',
  email: 'owner@example.com',
  password: 'password'
)

member = User.create!(
  first_name: 'Member',
  last_name: 'User',
  email: 'member@example.com',
  password: 'password'
)

user = User.create!(
  first_name: 'Basic',
  last_name: 'User',
  email: 'user@example.com',
  password: 'password'
)

multiple_owners = Project.create!(name: 'Multiple Owners')
Membership.create!(
  project: multiple_owners,
  user: owner,
  role: :owner
)
Membership.create!(
  project: multiple_owners,
  user: user,
  role: :owner
)
Membership.create!(
  project: multiple_owners,
  user: member,
  role: :member
)

task1 = Task.create!(
  description: "Write 3 comments",
  project: multiple_owners,
  due_date: 4.days.from_now
)

task2 = Task.create!(
  description: "Write 1 comment",
  project: multiple_owners,
  due_date: 5.days.from_now
)

3.times do
  Comment.create!(
    task_id: task1.id,
    user: owner,
    content: Faker::Lorem.sentence
  )
end

Comment.create!(
  task_id: task2.id,
  user: member,
  content: Faker::Lorem.sentence
)

single_owner = Project.create!(name: 'Single Owner')
Membership.create!(
  project: single_owner,
  user: owner,
  role: :owner
)
Membership.create!(
  project: single_owner,
  user: member,
  role: :member
)
=begin
User.destroy_all
Project.destroy_all
Task.destroy_all
Comment.destroy_all
Membership.destroy_all

rand(6..12).times do
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

rand(3..6).times do
  project = Project.create(
    name: "#{Faker::Hacker.noun.capitalize} Project",
  )
  rand(3..9).times do
    task = Task.create(
      description: "#{Faker::Hacker.verb.capitalize} #{project.name}",
      due_date: Faker::Time.forward(23),
      complete: [false, false, false, true].sample,
      project_id: project.id
    )
    rand(0..3).times do
      Comment.create(
        content: "#{Faker::Company.bs} #{task.description}",
        task_id: task.id,
        user_id: User.all.sample.id
      )
    end
  end
  rand(3..6).times do
    Membership.create(
      project_id: project.id,
      user_id: User.all.sample.id,
      role: [0,0,0,1].sample
    )
  end
end
=end
