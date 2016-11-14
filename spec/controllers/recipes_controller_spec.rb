require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  it "logged in user can save recipes" do
    login("dave")
    recipe = Recipe.new
    recipe.user = current_user
    recipe.recipe_id = "../recipes/100000"
    recipe.save
    expect(recipe).to be_valid
  end

  it "logged in user cannot save same recipe(duplicate)" do
    login("dave")
    recipe = Recipe.new
    recipe.user = current_user
    recipe.recipe_id = "../recipes/001"
    recipe.save
    expect(recipe).to_not be_valid
  end

  it "should not able to create recipes without current_user" do
    login("dave")
    recipe = Recipe.new
    recipe.user = nil
    recipe.recipe_id = "http://recipe/1"
    expect(recipe).to_not be_valid
  end

  it 'Fetch recipies' do
    conn = Faraday.new(:url => ENV['API_URL'] ) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    url_params = {:q => "ALL", :app_id => ENV['APP_ID'] , :app_key => ENV['APP_KEY']}.to_query

    response = conn.get "/search?"+url_params
    json = JSON.parse(response.body)
    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of recipes are returned
    # 10 recipes are returned on page 1 by edmamm api.
    expect(json['hits'].length).to eq(10)
  end


  it 'Fetch recipe by id & save its child nodes ' do
    conn = Faraday.new(:url => ENV['API_URL'] ) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    id = "http://www.edamam.com/ontologies/edamam.owl#recipe_097b3aabe8634954195d8599e14fc6ec"
    url_params = {:r => id, :app_id => ENV['APP_ID'] , :app_key => ENV['APP_KEY']}.to_query

    response = conn.get "/search?"+url_params
    json = JSON.parse(response.body)
    json = json[0]
    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of recipes are returned
    # 10 recipes are returned on page 1 by edmamm api.
    expect(json['uri']).to match(id)

    login("dave")
    recipe = current_user.recipes.build(:recipe_id => id)
    recipe.save_from_response(json)

  end


end
