class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # validates if comment is not empty
  # validates :comment_text, presence: true

  def comment_or_error_can_be_empty
    if self.comment_text.blank?
      validates :vote != 0
    elsif self.vote == 0
      validates :comment_text, presence: true
    end
  end


end
