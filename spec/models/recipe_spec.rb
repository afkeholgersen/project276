require 'rails_helper'

RSpec.describe Recipe, type: :model do

    describe "Associations" do
      it "belongs to :user" do
        assc = described_class.reflect_on_association(:user)
        expect(assc.macro).to eq :belongs_to
      end
      it "has many :ingredients" do
        assc = described_class.reflect_on_association(:ingredients)
        expect(assc.macro).to eq :has_many
      end
      it "has many :ingredient_lines" do
        assc = described_class.reflect_on_association(:ingredient_lines)
        expect(assc.macro).to eq :has_many
      end
      it "has many :total_daily_nodes" do
        assc = described_class.reflect_on_association(:total_daily_nodes)
        expect(assc.macro).to eq :has_many
      end
      it "has many :total_nutrient_nodes" do
        assc = described_class.reflect_on_association(:total_nutrient_nodes)
        expect(assc.macro).to eq :has_many
      end
    end



    recipe = Recipe.new(recipe_id: "http://recipe/100")



    it "is valid with valid attributes" do
      recipe.user = get_user_by_username("dave")
      expect(recipe).to be_valid
    end

    it "is not valid without API recipe_id" do
      recipe.recipe_id = nil
      expect(recipe).to_not be_valid
    end

    it "is not valid without user record in database" do
      recipe.user_id = 999
      expect(recipe).to_not be_valid
    end


    it "is not valid without a user_id field" do
      expect(recipe).to_not be_valid
    end

end
