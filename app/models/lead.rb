class Lead < ApplicationRecord
    validates :project_name, :client_name, :client_address, :client_email, :client_contact, :platform, :test_type, :status, presence: true

    enum status: {
         created: 0,
         in_progress: 1,
         sale: 2,
         not_sale: 3,
     }
    
    enum test_type: {
        test_project: 0,
        oncall_interview: 1,
    }
    belongs_to :user
    has_many :phases, dependent: :destroy 
    has_one :project
    has_many :comments, as: :commentable
end
