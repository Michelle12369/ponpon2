class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @post = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.all
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    # @post = Post.new(post_params) do |post|
    #   post.user = current_user
    # end
    # respond_to do |format|
    #   if @post.save
    #   redirect_to root_path
    # else
    #   redirect_to root_path, notice: @post.errors.full_messages.first
    # end
    # end

      @post = current_user.posts.new(post_params)
    if @post.save
      @activity=@post.activities[0]
      @user=current_user
      @friends = @user.user_followers
      
      
      for friend in @friends
        Pusher['test_channel'+friend.id.to_s].trigger('greet', {
          :post =>@post,
          :user =>current_user,
          :activity =>@activity
        })
      end
      
      respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
    else
      redirect_to root_path, notice: @post.errors.full_messages.first
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.update(post_params)
    redirect_to @post
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @post }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    @activity = PublicActivity::Activity.find_by(trackable_id: (params[:id]), trackable_type: controller_path.classify)
    @activity.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:attachment, :content, :user_id)
    end
end
