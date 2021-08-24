class Lead < ApplicationRecord
    validates :project_name, :client_name, :client_address, :client_email, :client_contact, :platform, :test_type, :status, presence: true

    enum status: [:created, :in_progress, :sale, :not_sale]
    enum test_type: [:test_project, :oncall_interview]

    belongs_to :user
    has_many :phases 
    has_one :project
end
