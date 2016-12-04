
class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :home, :save_recipe, :my_recipes]

  # GET /users
  # GET /users.json
  def index
    if current_user
      if current_user.role == 2
          redirect_to users_adminhome_path
      else
        redirect_to home_user_path(current_user)
      end
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
    #assign the default user role if not in user
    if @user.role == nil
      @user.role = 1;
    end

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
    
    begin
      currSavedRecipeList = Savedrecipe.find(@user.savedrecipe.id);
    rescue
      @user.savedrecipe = Savedrecipe.new
    end
      
    #deletes the password parameter if its empty so we don't get error that password is blank
    if user_params[:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

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

    puts @user
    @user.destroy
    respond_to do |format|


      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deleteuser

    if current_user 
      current_user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def adminhome
    if current_user
      if current_user.role != 2
        redirect_to home_user_path(current_user)
      end
    end
    @users = User.all
  end

  def search
    apiURL = ENV['API_URL'].to_s + "/search?app_id=" + ENV['APP_ID'].to_s + "&app_key="+ ENV['APP_KEY'].to_s + "&q="
    
    healthLabelsSearch = ""
    dietLabelsSearch = ""
    minCalories = ""
    maxCalories = ""

    if params["healthlabel_apiparameters"]
      params["healthlabel_apiparameters"].each do |hlapi|
        healthLabelsSearch += "&health="+hlapi
      end
    end
    if params["dietlabel_apiparameters"]
      params["dietlabel_apiparameters"].each do |dlapi|
        dietLabelsSearch += "&diet="+dlapi
      end
    end

    if params[:mincalories].size > 0 and params[:maxcalories].size > 0
      minCalories = "&calories=gte%20" + params[:mincalories]
      maxCalories = ",lte%20" + params[:maxcalories]
    elsif params[:mincalories].size > 0
      minCalories = "&calories=gte%20" + params[:mincalories]
    elsif params[:maxcalories].size > 0
      maxCalories = "&calories=lte%20" + params[:maxcalories]
    end

    baseURL=apiURL+params[:search]
    baseURL += healthLabelsSearch + dietLabelsSearch + minCalories + maxCalories
    puts baseURL
    resp = RestClient.get(baseURL)

    if resp != nil
      json_resp = JSON.parse(resp)
      if current_user
        json_resp["hits"].each do |js|
          recipe_exists = current_user.savedrecipe.recipe.where(:source => js["recipe"]['uri']).first
          if recipe_exists
            js["recipe"]['rExist'] = 1
            JSON[js]
          else
            js["recipe"]['rExist'] = 0
            JSON[js]
          end
        end
      end
      @searchResults = json_resp
      respond_to do |format|
        format.html
      end
    end

  end

  def home

  end

  def save_recipe
    recipe = params[:recipe]
    #puts recipe
    recipe_uri = recipe['uri']
    #logger.debug recipie_url
    recipe_exists = Recipe.where(:source => recipe_uri).first
    dietLabelsString = ""
    healthLabelsString = ""
    if recipe["dietLabels"]
      dietLabelsString =  recipe["dietLabels"].join(",")
    end
    if recipe["healthLabels"]
      healthLabelsString =  recipe["healthLabels"].join(",")
    end

    r = Recipe.new(:source => recipe_uri, :sourceIcon => recipe["image"], :dietLabels => dietLabelsString, :healthLabels => healthLabelsString, :title => recipe['label'])

    if recipe_exists
      logger.debug "CALLING IF"
      recipe_exists_user = @user.savedrecipe.recipe.where(:source => recipe_uri).first
      if recipe_exists_user
         @message = "Recipe is available in your saved recipes list"

      else
        @user.savedrecipe.recipe.push(recipe_exists);
        @message = "Saved successfully"
      end
      
    elsif !recipe_exists
      logger.debug "CALLING ELSEIF"
      @user.savedrecipe.recipe.push(r)
      r.save
      @user.savedrecipe.save
      @message = "Saved successfully"
    else
      @message = "Unable to save recipe "+ @user.errors.full_messages.to_sentence
    end

  end



  def all_recipes
    @foundLinks = []
    currentPage = 0;
    retryCount = 0;

    apiURL = ENV['API_URL'].to_s + "/search?app_id=" + ENV['APP_ID'].to_s + "&app_key="+ ENV['APP_KEY'].to_s + "&r="

    baseURL = "https://www.edamam.com/recipes/-/"
    current_user.preference.healthlabel.each do |hlabel|
      baseURL += hlabel.apiparameter+"/"
    end
    current_user.preference.dietlabel.each do |dlabel|
      baseURL += dlabel.apiparameter+"/"
    end
    #page = Nokogiri::HTML(open(baseURL))
    #opens up the page using watir (based off of selinium) using phantomjs driver
    brows = Watir::Browser.new(:phantomjs)
    brows.goto baseURL

    if params[:loadmore]
      while currentPage < params[:loadmore].to_i
        brows.driver.execute_script("window.scrollTo(0,document.body.scrollHeight);");
        puts "EXECUTED SCROLL!"
        sleep(1)
        currentPage+=1
      end
    end    
    #http://api.edamam.com/search?app_id=ed2714cc&app_key=81029d1bb3daad9d1bdaf4a46adca6b2&r="

    #wait for AJAX calls to poplate div's


      doc = Nokogiri::HTML(brows.html)
      doc.css("li[itemtype='http://schema.org/Thing']").each do |link|
        logger.debug link['data-id']
        @foundLinks.push(link['data-id'])
        #logger.debug resp.body
      
    end

      @foundLinks.each do |uri|
        apiURL += uri+"&r=";
      end
      puts apiURL

      while (retryCount < ENV['RETRYMAX'].to_i)
        begin
          resp = RestClient.get(apiURL)
          break
        rescue
          puts "RETRYING"
          retryCount += 1
        end
      end

      resp += ']'

      if resp != nil
        json_resp = JSON.parse(resp)
        json_resp.each do |js|
          recipe_exists = current_user.savedrecipe.recipe.where(:source => js['uri']).first
          if recipe_exists
            js['rExist'] = 1
            JSON[js]
          else
            js['rExist'] = 0
            JSON[js]
          end  
        end

        respond_to do |format|
          format.json {render json: json_resp, status: :ok }
        end
      end
    end

  def individual_recipes
    logger.debug "HAPPENING"

    uri = params['uri']
    apiURL = ENV['API_URL'].to_s + "/search?app_id=" + ENV['APP_ID'].to_s + "&app_key="+ ENV['APP_KEY'].to_s + "&r="
    conn = Faraday.new(:url => "") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger               # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

      logger.debug uri
      recipeInfo = apiURL+uri

      uri = URI.unescape(uri)
      logger.debug uri
      recipe_exists = current_user.savedrecipe.recipe.where(:source => uri).first
      resp = conn.get recipeInfo
      if resp.body != nil
        json_resp = JSON.parse(resp.body)
        if recipe_exists
          json_resp[0]['rExist'] = 1
          puts JSON[json_resp[0]]
          respond_to do |format|
            format.json {render json: json_resp[0], status: :ok }
          end
        else
          json_resp[0]['rExist'] = 0
          puts JSON[json_resp[0]]
          respond_to do |format|
            format.json {render json: json_resp[0], status: :ok }
          end
        end

      end

  end


  def unsave_recipe
    recipe_url= params[:recipe_url]
    recipe_exists = current_user.savedrecipe.recipe.where(:source => recipe_url).first
    if recipe_exists
      current_user.savedrecipe.recipe.destroy(current_user.savedrecipe.recipe.where(:source => recipe_url).first.id)
      @message= "Removed from your recipes list"
    else
      @message= "Already removed from your recipes list"
    end
  end
  #will this delete all savings of this in the database?


  def my_recipes
    @recipes = @user.savedrecipe.recipe
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

        elsif @user != p_user && @user.role == 1
          flash[:notice] = "Unauthorized access"
          redirect_to home_user_path(@user) and return

        #case where user is an admin
        elsif @user.role == 2
          #we set the current user to whichever one the admin put in the url
          @user = User.find(params[:id])
        end


      end
    end

    # Allow only certain field through
    def user_params
      return {} if params[:user].blank?
      params.require(:user).permit(:username, :email, :password, :preference_id, :password_confirmation, :role)

    end

    # Just need these two fields to create a preference
    def preference_params
      params.require(:preference).permit(healthlabel_ids: [], dietlabel_ids: [])
    end

end
