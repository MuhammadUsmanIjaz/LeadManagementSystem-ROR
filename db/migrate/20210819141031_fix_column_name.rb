class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :phases, :type, :test_type
  end
end
