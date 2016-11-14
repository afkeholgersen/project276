class Recipe < ApplicationRecord
	has_and_belongs_to_many :savedrecipe
	belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :ingredient_lines, dependent: :destroy
  has_many :total_daily_nodes, dependent: :destroy
  has_many :total_nutrient_nodes, dependent: :destroy

  validates :recipe_id, presence: true
  validates :recipe_id, :uniqueness => { :scope => [:user_id],:message => "** Recipe is saved **" }

  def save_from_response(resp)
    recipe = self
    recipe.recipe_name = resp["label"]
    recipe.image_url = resp["image"]
    recipe.share_as = resp["shareAs"]
    recipe.dietLabels = resp["dietLabels"].to_s
    recipe.healthLabels = resp["healthLabels"].to_s
    recipe.cautions = resp["cautions"].to_s
    recipe.source = resp["source"]
    recipe.sourceIcon = resp["sourceIcon"]
    recipe.calories = resp["calories"].to_s
    recipe.totalWeight = resp["totalWeight"].to_s

    if recipe.save
      resp["ingredients"].each do |i|
        igt =recipe.ingredients.build(text: i["text"], quantity: i["quantity"], measure: i["measure"], food: i["food"], weight: i["weight"])
        igt.save!
      end

      resp["ingredientLines"].each do |i|
        igt =recipe.ingredient_lines.build(text: i)
        igt.save!
      end

      resp["totalNutrients"].each do |i|
        k = i[0]
        v = i[1]
        igt =recipe.total_nutrient_nodes.build(label: v["label"], quantity: v["quantity"], unit: v["unit"], node_label: k)
        igt.save!
      end

      resp["totalDaily"].each do |i|
        k = i[0]
        v = i[1]
        igt =recipe.total_daily_nodes.build(label: v["label"], quantity: v["quantity"], unit: v["unit"], node_label: k)
        igt.save!
      end
      return true
    else
      p recipe.errors
      return false
    end
  end

end
