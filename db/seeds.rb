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
