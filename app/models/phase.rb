class Phase < ApplicationRecord
    enum status: [:created, :in_progress, :completed]
    enum test_type: [:test_project, :interview]
    enum invitation_status: [:pending, :accepted, :rejected]

    belongs_to :lead
    has_many :user_phases
    has_many :users, through: :user_phases
end
