require 'rails_helper'

def create_user
  @user = User.create email: 'ironman@stark.industries.com',
                      password: 'jarvis', firstname: 'tony',
                      lastname: 'stark', role: 'subscriber'
end

def create_admin
  @user = User.create email: 'punisher@marvel.com',
                      password: 'fairground', firstname: 'frank',
                      lastname: 'castle', role: 'admin'
end

def log_in(email, password)
  visit root_path
  fill_in 'Email', with: email
  fill_in('Password', with: password, match: :prefer_exact)
  click_button('Log in')
end

def add_subject(name)
  @subject = Subject.create subject: name, difficulty: 1, points: 1
end

def add_multiple_subjects
  add_subject('Daredevil')
    add_subject('Iron Fist')
    add_subject('Jessica Jones')
    add_subject('Luke Cage')
    add_subject('Punisher')
end

feature 'Access New Subject Page' do
  scenario 'Unregistered user attempts to add new subject' do
    visit root_path
    visit '/subjects/new'

    expect(page).to have_content 'Log in'
  end

  scenario 'Subscriber attempts to add new subject' do
    add_multiple_subjects
    create_user
    log_in(@user.email, @user.password)
    visit '/subjects/new'

    expect(page).to have_content 'Daredevil Iron Fist Jessica Jones Luke Cage Punisher'
  end

  scenario 'Admin user attempts to add new subject' do
    add_multiple_subjects
    create_admin
    log_in(@user.email, @user.password)
    visit '/subjects/new'

    expect(page).to have_content 'Subject Difficulty Points'
  end  
end

feature 'Create New Subject' do
  scenario 'Admin user creates a new subject' do
    add_multiple_subjects
    create_admin
    log_in(@user.email, @user.password)
    visit '/subjects/new'

    fill_in 'Subject', with: 'Identities'
    fill_in 'Difficulty', with: '1'
    fill_in 'Points', with: '1'
    click_button('Create Subject')

    expect(page).to have_content 'Subject successfully created'
  end
end

feature 'Access Edit Subject Page' do
  scenario 'Unregistered user attempts to edit a subject' do
    add_subject('Abilities')

    visit root_path
    visit '/subjects/1/edit'

    expect(page).to have_content 'Log in'
  end

  scenario 'Subscriber attempts to edit a subject' do
    add_multiple_subjects
    add_subject('Abilities')

    create_user
    log_in(@user.email, @user.password)
    visit root_path
    visit '/subjects/1/edit'

    expect(page).to have_content 'Daredevil Iron Fist Jessica Jones Luke Cage Punisher'
  end

  scenario 'Admin user attempts to edit a subject' do
    add_multiple_subjects
    add_subject('Abilities')

    create_admin
    log_in(@user.email, @user.password)
    visit root_path
    visit '/subjects/1/edit'

    expect(page).to have_content 'Edit Subject'
  end
end

feature 'Edit A Subject' do
  scenario 'Admin user edits a subject' do
    add_multiple_subjects
    add_subject('Aliases')
    create_admin
    log_in(@user.email, @user.password)
    visit '/subjects/1/edit'

    fill_in 'Subject', with: 'Aliases'
    fill_in 'Difficulty', with: '3'
    fill_in 'Points', with: '1'
    click_button('Update Subject')

    expect(page).to have_content 'Subject successfully updated'
  end
end