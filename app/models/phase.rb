class Phase < ApplicationRecord
    validates :assignee, :start_date, :due_date, :status, :test_type, :invitation_status,  presence: true

    enum status: [:created, :in_progress, :completed]
    enum test_type: [:test_project, :interview]
    enum invitation_status: [:pending, :accepted, :rejected]

    belongs_to :lead
    has_many :user_phases, dependent: :destroy 
    has_many :users, through: :user_phases
end
