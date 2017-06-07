class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :form_template, foreign_key: true
      t.integer :qns_type
      t.string :label
      t.string :options

      t.timestamps
    end
  end
end
