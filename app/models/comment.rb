class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # validates if comment is not empty
  def comment_or_error_can_be_empty
    if self.vote.nil?
      validates :comment_text, presence: true
    else
      validates :comment_text, presence: true
    end
  end
end
