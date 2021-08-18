class Phase < ApplicationRecord
    enum status: [:created, :in_progress, :completed]
    enum type: [:test_project, :interview]
    enum invitation_status: [:pending, :accepted, :rejected]
end
