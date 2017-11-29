class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true
      t.text :answered_question

      t.timestamps
    end
  end
end
