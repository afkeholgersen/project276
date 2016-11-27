class Recipe < ApplicationRecord
	has_and_belongs_to_many :savedrecipe

	has_many :comments, dependent: :destroy
end
