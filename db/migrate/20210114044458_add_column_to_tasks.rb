class AddColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :user_id, :string
  end
end
