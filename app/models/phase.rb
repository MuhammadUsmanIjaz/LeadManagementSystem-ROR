class Phase < ApplicationRecord
    #dates should not be in past see custom validations
    validates :assignee, :start_date, :due_date, :status, :test_type, :invitation_status,  presence: true
    validate :start_date_cannot_be_in_the_past,:due_date_cannot_be_in_the_past, on: :create

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Start Date can't be in the past!")
    end 
  end

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Due Date can't be in the past!")
    end 
  end



    enum status: {
        created: 0, 
        in_progress: 1, 
        completed: 2,
    }
    enum test_type: {
        test_project: 0, 
        interview: 1,
    }
    enum invitation_status: {
        pending: 0, 
        accepted: 1, 
        rejected: 2,
    }

    belongs_to :lead
    has_many :user_phases, dependent: :destroy 
    has_many :users, through: :user_phases
    has_many :comments, as: :commentable
end
