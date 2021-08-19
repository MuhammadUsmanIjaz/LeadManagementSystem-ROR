class AddUserToLeads < ActiveRecord::Migration[6.1]
  def change
    add_reference :leads, :user, null: false, foreign_key: true
  end
end
