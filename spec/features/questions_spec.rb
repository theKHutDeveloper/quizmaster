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

def add_question
  @question = Question.create subject_id: 1,
                              question: "What is Luke Cage's superpower?",
                              choice1: 'Flying', choice2: 'Teleporting',
                              choice3: 'Iron fist',
                              answer: 'resistance to physical injury'
end

feature 'Access New Question Page' do
  scenario 'Unregistered user attempts to add a new question' do
    visit root_path
    visit '/questions/new'

    expect(page).to have_content 'Log in'
  end

  scenario 'Subscriber attempts to add a new question' do
    add_multiple_subjects

    create_user
    log_in(@user.email, @user.password)
    visit '/questions/new'

    expect(page).to have_content 'Daredevil Iron Fist Jessica Jones Luke Cage Punisher'
  end

  scenario 'Admin user attempts to add a new question' do
    add_multiple_subjects

    create_admin
    log_in(@user.email, @user.password)
    visit '/questions/new'

    expect(page).to have_content 'Question Choice1 Choice2 Choice3 Answer'
  end
end

feature 'Create New Question' do
  scenario 'Admin user creates a new question' do
    add_multiple_subjects
    add_subject('Identities')

    create_admin
    log_in(@user.email, @user.password)
    visit '/questions/new'

    select 'Identities', from: 'question_subject_id'
    fill_in 'Question', with: "What is Daredevil's real name?"
    fill_in 'Choice1', with: 'Jessica Jones'
    fill_in 'Choice2', with: 'Luke Cage'
    fill_in 'Choice3', with: 'Foggy Nelson'
    fill_in 'Answer', with: 'Matthew Murdock'
    click_button('Create Question')

    expect(page).to have_content 'Question successfully created'
  end
end

feature 'Access Edit Question Page' do
  scenario 'Unregistered user attempts to edit a question' do
    add_subject('Abilities')
    add_question

    visit root_path
    visit '/questions/1/edit'

    expect(page).to have_content 'Log in'
  end

  scenario 'Subscriber user attempts to edit a question' do
    add_multiple_subjects
    add_subject('Abilities')
    add_question

    create_user
    log_in(@user.email, @user.password)
    visit root_path
    visit '/questions/1/edit'

    expect(page).to have_content 'Daredevil Iron Fist Jessica Jones Luke Cage Punisher'
  end

  scenario 'Admin user attempts to edit a question' do
    add_multiple_subjects
    add_subject('Abilities')
    add_question

    create_admin
    log_in(@user.email, @user.password)
    visit root_path
    visit '/questions/1/edit'

    expect(page).to have_content 'Edit Question'
  end
end

feature 'Edit A Question' do
  scenario 'Admin user edits a question' do
    add_multiple_subjects
    add_subject('Abilities')
    add_question

    create_admin
    log_in(@user.email, @user.password)
    visit root_path
    visit '/questions/1/edit'

    fill_in 'Answer', with: 'Unbreakable skin'
    click_button('Update Question')

    expect(page).to have_content 'Question successfully updated'
  end
end
