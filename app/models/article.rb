class Article < ApplicationRecord
  after_validation :set_slug, only: [:create, :update]
  include ImageUploader::Attachment(:image)

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true

  def set_slug
    self.slug = title.to_s.parameterize
  end 

  def to_param
    "#{id}-#{slug}"
  end
end
