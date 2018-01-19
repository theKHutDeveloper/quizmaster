class AddScoreToQuizzes < ActiveRecord::Migration[5.1]
  def change
  	add_column :quizzes, :score, :float
  end
end
