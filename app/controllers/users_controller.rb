class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :home, :save_recipe, :my_recipes]

  # GET /users
  # GET /users.json
  def index
    if current_user
      redirect_to home_user_path(current_user)
    else
      redirect_to new_session_path
    end
    #@users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @preference = Preference.new
    @healthlabels = Healthlabel.all;
    @dietlabels = Dietlabel.all;

  end

  # GET /users/1/edit
  def edit
    @preference = Preference.new
  end

  # POST /users
  # POST /users.json
  def create

    @healthlabels = Healthlabel.all;
    @dietlabels = Dietlabel.all;

    #create the new preference with the preference parameters we accept
    @preference = Preference.new(preference_params)
    #create the new user with the user parameters we accpet
    @user = User.new(user_params)

    #assign the current preference to the user
    @user.preference = @preference

    #create a blank recipe table entry for the user to save recipes to
    @user.savedrecipe = Savedrecipe.new
    #assign the default user role
    @user.role = 1;

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_session_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    @healthlabels = Healthlabel.all;
    @dietlabels = Dietlabel.all;

    #create the new preference with the preference parameters we accept
    @preference = Preference.new(preference_params)

    #assign the current preference to the user and a new recipe
    @user.preference = @preference
    @user.savedrecipe = Savedrecipe.new

    respond_to do |format|

      if @user.update(user_params)
        if params[:redirect_to].present?
          format.html { redirect_to home_user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :found, location: @user }
        else
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :found, location: @user }
        end


      else
        format.html { render :edit  }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def home
    health = @user.preference.healthlabel.first.apiparameter rescue ""
    diet = @user.preference.dietlabel.first.apiparameter rescue ""

    response,req_status = initiate_recommendation_request(params,{diet: diet, health: health})

    if req_status.to_i == 403 || req_status.to_i == 404
      ############################
      response,req_status = initiate_recommendation_request(params,{diet: diet})

      if req_status != 403 && req_status != 404
        # show recommendations based on diet if combination of Diet & Health fails
          resp = response.body
      else

        response,req_status = initiate_recommendation_request(params,{health: health})

        if req_status != 403 && req_status != 404
          # show recommendations based on health if combination of (Diet & Health fails) as well as only Diet- fails
          resp = response.body
        end
      end

      if resp == nil
        # If no labels renders results then show then top recipes
        response,req_status = initiate_recommendation_request(params,{q: "ALL"})
        if req_status != 403 || req_status != 404
          resp = response.body
        else
          resp = {:hits => {}, :error => "No results found for search criteria"}.to_json
        end
      end

      @json_resp = JSON.parse(resp)
    else
      # Success with both diet & health labels
      @json_resp = JSON.parse(response.body)
    end
  end

  def initiate_recommendation_request(params,request_params_hash)
    conn = Faraday.new(:url => ENV['API_URL'] ) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    url_hash = {:q => "", :app_id => ENV['APP_ID'] , :app_key => ENV['APP_KEY']}
    if params[:to].present?
      f = params[:to].to_i
      l = f +10
      url_hash[:from] =  f.to_s
      url_hash[:to] = l.to_s
    end
    url_hash = url_hash.merge(request_params_hash)

    url_params = url_hash.to_query
    response = conn.get "/search?"+url_params
    return [response,response.status]
  end

  def save_recipe
    recipie_url = params[:recipe_url]
    recipe_exists = @user.recipes.where(:recipe_id => recipie_url).first

    if !recipe_exists && save_recipes_attributes(@user,recipie_url)
      @message = "Saved successfully"
    elsif recipe_exists
       @message = "Recipe is available in your saved recipes list"
    else
      @message = "Unable to save recipe "+@user.errors.full_messages.to_sentence
    end
  end

  def my_recipes
    @recipes = @user.recipes
  end

  def save_recipes_attributes(user,recipe_id)

    recipe = user.recipes.build(:recipe_id => recipe_id)

    conn = Faraday.new(:url => ENV['API_URL'] ) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    url_hash = {:r => recipe_id, :app_id => ENV['APP_ID'] , :app_key => ENV['APP_KEY']}
    url_params = url_hash.to_query

    response = conn.get "/search?"+url_params
    if response.status == 403 || response.status == 404
      @json_resp= JSON.parse({:hits => {}, :error => "Unable to fetch recipe."}.to_json)
      return false
    else
      @json_resp = JSON.parse(response.body)
    end
    resp = @json_resp[0]

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
      return false
    end

  end


  #only call these methods within the class
  private

    def set_user
      p_user = User.find(params[:id]) rescue nil
      @user = current_user
      if @user.blank? || (@user != p_user)
        if @user.blank?
          flash[:notice] = "Log in/ sign up to continue"
          redirect_to new_session_path and return
        else
          flash[:notice] = "Unauthorized access"
          redirect_to home_user_path(@user) and return
        end
      end
    end

    # Allow only certain field through
    def user_params
      return {} if params[:user].blank?
      params.require(:user).permit(:username, :email, :password, :preference_id, :password_confirmation)
    end

    # Just need these two fields to create a preference
    def preference_params
      params.require(:preference).permit(:healthlabel_ids, :dietlabel_ids)
    end
end
