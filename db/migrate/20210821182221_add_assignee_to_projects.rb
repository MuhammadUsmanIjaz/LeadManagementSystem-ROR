class AddAssigneeToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :assignee, :string
  end
end
