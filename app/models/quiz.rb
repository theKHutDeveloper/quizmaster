# Quiz model class
class Quiz < ApplicationRecord
	# store :answered_questions, accessors: [:question_id, :user_answer]

  belongs_to :user
  belongs_to :subject

  scope :questions, -> (subject_id) { Question.where(subject_id: subject_id) }
  scope :size, -> (subject_id) { Question.where(subject_id: subject_id).count }

  def self.choices(subject_id)
  	quest = Question.where(subject_id: subject_id)
  	list = quest.pluck(:choice1, :choice2, :choice3, :answer)

		list.each do |choice|
			choice.select! { |a| a.length > 0 }
  		choice.shuffle!
  	end

  	list
  end

  def self.answers(subject_id)
    Question.where(subject_id: subject_id).distinct.pluck(:id, :answer)
  end

  def self.result(subject_id, answered_questions)
    user_answers = JSON.parse(answered_questions)
    answers = answers(subject_id)
    correct = 0

    size = user_answers["answers"].size

    user_answers["answers"].each do |user_answer|
      question_id = user_answer["question_id"]
      answer = answers.detect { |a| a[0] == question_id }

      if !answer.nil?
        if answer[1] == user_answer["answer"]
          correct += 1
        end
      end
    end

    percentage = (correct.to_f / size) * 100
  end
end

