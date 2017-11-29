# Subject model class
class Subject < ApplicationRecord
  has_many :questions

  scope :uniq_subjects, -> { distinct.pluck(:subject) }
end
