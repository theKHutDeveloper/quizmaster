# Create quiz subject
class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :subject
      t.integer :difficulty
      t.integer :points
      t.timestamps
    end
  end
end
