class CreatePhases < ActiveRecord::Migration[6.1]
  def change
    create_table :phases do |t|
      t.string :assignee
      t.datetime :start_date
      t.datetime :due_date
      t.integer :status
      t.integer :type
      t.integer :invitation_status

      t.timestamps
    end
  end
end
