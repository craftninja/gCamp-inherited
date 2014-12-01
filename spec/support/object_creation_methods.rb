def create_user(overrides = {})
  User.create!({
    :first_name => "First Name #{rand(100..999)}",
    :last_name => "Last Name #{rand(100..999)}",
    :email => "email#{rand(100..999)}@email.com",
    :password => 'password'
    }.merge(overrides)
  )
end

def create_project(overrides = {})
  Project.create!({
    :name => "Project Name #{rand(100..999)}"
    }.merge(overrides)
  )
end

def create_task(project, overrides = {})
  Task.create!({
    :description => "Task Desc #{rand(100..999)}",
    :project_id => project.id
    }.merge(overrides)
  )
end

def create_comment(task, overrides = {})
  Comment.create!({
    :content => "Comment content #{rand(100..999)}",
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
