class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :form, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
