class AddLeadToPhases < ActiveRecord::Migration[6.1]
  def change
    add_reference :phases, :lead, null: false, foreign_key: true
  end
end
