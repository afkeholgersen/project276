class Recipe < ApplicationRecord
	has_and_belongs_to_many :savedrecipe
	belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :ingredient_lines, dependent: :destroy
  has_many :total_daily_nodes, dependent: :destroy
  has_many :total_nutrient_nodes, dependent: :destroy
	has_many :comments, dependent: :destroy

end
