class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # validates if comment is not empty
  def comment_or_error_can_be_empty
    if self.comment_text.blank?
      validates :vote, other_than: 0
    else
      validates :comment_text, presence: true
      validates :vote, other_than: 0
    end
  end
end
