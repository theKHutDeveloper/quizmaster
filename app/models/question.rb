# Question model class
class Question < ApplicationRecord
  belongs_to :subject

  scope :by_subject, -> (id) { where(:subject_id => id) }

  def convert
  	arr = []

  	arr.push(choice1)
  	arr.push(answer)
  	arr.push(choice2) if !choice2.blank?
  	arr.push(choice3) if !choice3.blank?
  	arr.shuffle
  end
end
