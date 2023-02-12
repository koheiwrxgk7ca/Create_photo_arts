class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  validates :photo_comment, presence: true
end
