class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # validates if comment is not empty
  validates :comment_text, presence: true
end
