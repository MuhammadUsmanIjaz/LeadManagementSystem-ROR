class CreateUserPhases < ActiveRecord::Migration[6.1]
  def change
    create_table :user_phases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
