class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  validates :photo_comment, presence: true
  validates :photo_comment, length: { maximum: 100 }
end
