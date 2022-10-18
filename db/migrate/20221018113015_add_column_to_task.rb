class AddColumnToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline_on, :date, null: false
    add_column :tasks, :priority, :integer, null: false
    add_column :tasks, :status, :integer, null: false
  end
end
