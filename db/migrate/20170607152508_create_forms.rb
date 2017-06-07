class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.belongs_to :form_template, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.date :form_date
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
