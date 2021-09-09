class Comment < ApplicationRecord
  validates :commenter, :body,  presence: true

  belongs_to :commentable, polymorphic: true
  has_many_attached :avatars
end
