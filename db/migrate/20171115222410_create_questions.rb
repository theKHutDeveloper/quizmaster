# Create question for quiz
class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :subject, index: true
      t.text :question, null: false
      t.string :choice1, null: false
      t.string :choice2
      t.string :choice3
      t.string :answer, null: false
      t.timestamps
    end
  end
end
