require 'rails_helper'

feature 'About page' do
  scenario 'Page shows number of Projects, Tasks, Users, Members, Comments' do
    visit '/'
    click_on 'About'
    expect(page).to have_content('0 Projects, 0 Tasks, 0 Users, 0 Members, 0 Comments')

    project1 = create_project
    project2 = create_project
    project3 = create_project

    task11 = create_task(project1)
    task21 = create_task(project2)
    task22 = create_task(project2)
    task23 = create_task(project2)

    user1 = create_user
    user2 = create_user
    user3 = create_user
    user4 = create_user
    user5 = create_user
    user6 = create_user

    member11 = create_membership(project1, user1)
    member12 = create_membership(project1, user2)
    member13 = create_membership(project1, user3)
    member21 = create_membership(project2, user1)
    member24 = create_membership(project2, user4)
    member25 = create_membership(project2, user5)
    member31 = create_membership(project3, user1)
    member32 = create_membership(project3, user2)
    member33 = create_membership(project3, user3)
    member34 = create_membership(project3, user4)
    member36 = create_membership(project3, user6)

    comments = create_comment(task11)

    visit '/'
    click_on 'About'
    expect(page).to have_content('3 Projects, 4 Tasks, 6 Users, 11 Members, 1 Comment')
  end
end
