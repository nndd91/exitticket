class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.belongs_to :form, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
