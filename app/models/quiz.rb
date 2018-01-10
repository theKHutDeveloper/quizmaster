# Quiz model class
class Quiz < ApplicationRecord
	store :answered_questions, accessors: [:question_id, :user_answer]

  belongs_to :user
  belongs_to :subject

  scope :questions, -> (subject_id) { Question.where(subject_id: subject_id)}
  scope :size, -> (subject_id) { Question.where(subject_id: subject_id).count}

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
  	quest = Question.where(subject_id: subject_id)
  	answer = quest.distinct.pluck(:answer)
  end

  def self.radio
    :choice
  end
end










# def self.choices(subject_id)
  #   @question_object = Question.where(subject_id: subject_id)
  #   @questions = @question_object.distinct.pluck(:question)
  #   @choices = @question_object.pluck(:choice1, :choice2, :choice3, :answer)

    # p @question_object
  #   p @questions
  #   @choices.each do |choice|
  #     choice.shuffle!
  #   end
  #   return @question_object, @questions, @choices
  # end