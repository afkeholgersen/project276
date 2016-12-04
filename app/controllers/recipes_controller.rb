class RecipesController < ApplicationController
  def show
  	logger.debug "STARTING SHOW RECIPE"
  	r = Recipe.find(params[:id])
		uri = r.source
		logger.debug uri
		logger.debug "END URI"
    apiURL = ENV['API_URL'].to_s + "/search?app_id=" + ENV['APP_ID'].to_s + "&app_key="+ ENV['APP_KEY'].to_s + "&r="
    conn = Faraday.new(:url => "") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger               # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
      recipeInfo = apiURL+uri
      resp = conn.get recipeInfo
      if resp.body != nil
        begin
          json_resp = JSON.parse(resp.body)
          @recipe = json_resp[0]
          logger.debug @reicpe
          respond_to do |format|
          	format.html
          end
        rescue => ex
          logger.debug ex
        end


         # respond_to do |format|
         #   format.json {render json: json_resp[0], status: :ok }
         #  end

      end

    @recipe_comment = Recipe.find(params[:id])
    @comment = Comment.where(recipe_id: @recipe_comment).where.not(:comment_text => nil).where("comment_text <> ''").order(:id)


  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(:comment_text => params[:comment_text], :vote => params[:vote])
    current_user.comments.push(@comment)
    @recipe.comments.push(@comment)
    @comment.user = current_user
    @comment.recipe = @recipe
    @comment.save
  end

  def createComment
    @recipe = Recipe.find(params[:id])
    vote_exist = Comment.where(:comment_text => nil , :user_id => current_user, :recipe_id =>@recipe).first
    if vote_exist
      logger.debug "edit vote value"
      vote_exist.update(vote: params[:vote])
    elsif !vote_exist
      logger.debug "new vote"
      @comment = Comment.new(:vote => params[:vote])
      current_user.comments.push(@comment)
      @recipe.comments.push(@comment)
      @comment.user = current_user
      @comment.recipe = @recipe
      @comment.save
    else
      logger.debug "error!"
    end
  end

  def deleteComment
    comment_to_delete = Comment.where(:recipe_id => params[:id]).find(params[:comment_id])
    comment_to_delete.update(comment_text: "--DELETED--")
  end

end
