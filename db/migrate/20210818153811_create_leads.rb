class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.string :project_name
      t.string :client_name
      t.string :client_address
      t.string :client_email
      t.string :client_contact
      t.string :platform
      t.integer :test_type
      t.integer :status

      t.timestamps
    end
  end
end
