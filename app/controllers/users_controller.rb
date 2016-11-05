class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
      params.require(:preference).permit(healthlabel_ids:[], dietlabel_ids:[])
    end
end
