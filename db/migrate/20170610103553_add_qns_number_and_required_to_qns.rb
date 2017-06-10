class AddQnsNumberAndRequiredToQns < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :required, :boolean, null: false, default: true
    add_column :questions, :qns_no, :integer, null: false, default: 0
  end
end
