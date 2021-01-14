class AddColumnsToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :first_answer, :string
    add_column :questions, :second_answer, :string
    add_column :questions, :third_answer,  :string
    add_column :questions, :fourth_answer, :string
  end
end
