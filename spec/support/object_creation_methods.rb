def create_user(overrides = {})
  User.create!({
    :first_name => 'Thomas',
    :last_name => 'Iliffe',
    :email => 'tom@email.com',
    :password => 'password'
    }.merge(overrides)
  )
end

def create_project(overrides = {})
  Project.create!({
    :name => 'Discover new species'
    }.merge(overrides)
  )
end

def create_task(project, overrides = {})
  Task.create!({
    :description => 'Go cave diving',
    :project_id => project.id
    }.merge(overrides)
  )
end

def create_comment(task, overrides = {})
  Comment.create!({
    :content => 'Nitrox or air?',
    :task_id => task.id
    }.merge(overrides)
  )
end

def create_membership(project, user, overrides = {})
  Membership.create!({
    :project_id => project.id,
    :user_id => user.id,
    :role => :member
    }.merge(overrides)
  )
end
