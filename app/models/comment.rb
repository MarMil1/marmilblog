class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :body, presence: true, length: { minimum: 1 }
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
