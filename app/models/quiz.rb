class Quiz < ApplicationRecord
	store :answered_questions, accessors: [:question_id, :user_answer]

  belongs_to :user
  belongs_to :subject
end
