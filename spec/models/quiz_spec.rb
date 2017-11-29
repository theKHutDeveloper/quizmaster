require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(firstname: 'Andrien', lastname: 'Ricketts', 
                    email:'andrien26@gmail.com', password: 'password123')
    user.save

    subject = Subject.new(subject: 'Spiderman', difficulty: 1, points: 1)
    subject.save

    expect(Quiz.new(user_id: user.id , subject_id: subject.id)).to be_valid
  end

  it 'is not valid without a user' do
    quiz = Quiz.new(user_id: nil)
    expect(quiz).to_not be_valid
  end

  it 'is not valid without a subject' do
    quiz = Quiz.new(subject_id: nil)
    expect(quiz).to_not be_valid
  end
end
