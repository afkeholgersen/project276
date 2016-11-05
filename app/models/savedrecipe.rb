class Savedrecipe < ApplicationRecord
	has_many :user
	has_and_belongs_to_many :recipe
end
