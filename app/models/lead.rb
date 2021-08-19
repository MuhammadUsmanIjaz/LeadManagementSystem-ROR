class Lead < ApplicationRecord
    enum status: [:created, :in_progress, :sale, :not_sale]
    enum test_type: [:test_project, :oncall_interview]

    belongs_to :user
    has_many :phases 
    has_one :project
end
