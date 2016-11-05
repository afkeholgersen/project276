class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :home]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :found, location: @user }
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
    conn = Faraday.new(:url => 'https://api.edamam.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    url_params = ""
    if params[:to].present?
      f = params[:to].to_i
      l = f +10
      url_params='&from=' + f.to_s + '&to=' + l.to_s
    end
    @user = User.find(params[:id])
    item = ""
    item = @user.preference.healthlabel.first.name rescue "chiken"

    response = conn.get "/search?q=#{item}&app_id=ed2714cc&app_key=81029d1bb3daad9d1bdaf4a46adca6b2"+url_params
    @json_resp = JSON.parse(response.body)
  end

  #only call these methods within the class
  private

    def set_user
      @user = User.find(params[:id])
    end

    # Allow only certain field through
    def user_params
      params.require(:user).permit(:username, :email, :password, :preference_id, :password_confirmation)
    end

    # Just need these two fields to create a preference
    def preference_params
      params.require(:preference).permit(:healthlabel_ids, :dietlabel_ids)
    end
end
