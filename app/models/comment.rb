class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many   :comments, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many   :comment_likes, dependent: :destroy
  validates  :body, presence: true, length: { minimum: 1 }
  validates  :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
