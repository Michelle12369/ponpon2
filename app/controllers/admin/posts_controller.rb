class Admin::PostsController < Admin::BaseController
  before_action :set_admin_post, only: [:edit, :update, :destroy]

  # GET /admin/posts
  # GET /admin/posts.json
  def index
    @admin_post = Admin::Post.new
    posts= PublicActivity::Activity.where(owner_id: @current_store,owner_type:"Store").order(created_at: :desc)
    @admin_posts =posts.paginate(page: params[:page], per_page: 10)
    @admin_pics=posts
  end

  # GET /admin/posts/1
  # GET /admin/posts/1.json
  def show
    @admin_post=PublicActivity::Activity.where(trackable_id: params[:id])
  end

  # GET /admin/posts/new
  def new
    @admin_post = Admin::Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @admin_post = @current_store.posts.new(admin_post_params)
    respond_to do |format|
      if @admin_post.save
        @admin_activity=@admin_post.create_activity(:create, :owner => @current_store)
        format.html { redirect_to admin_posts_path, notice: 'Post was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/posts/1
  # PATCH/PUT /admin/posts/1.json
  def update
    respond_to do |format|
      if @admin_post.update(admin_post_params)
        format.html { redirect_to admin_posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_post }
      else
        format.html { render :edit }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/posts/1
  # DELETE /admin/posts/1.json
  def destroy
    @admin_post.destroy
    @activity = PublicActivity::Activity.find_by(trackable_id: (params[:id]), trackable_type: "Post")
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.js
    end
  end

  def analysis
    @week_followers=Follow.recent(1.weeks.ago).where(followable_type:"Store",followable_id:@current_store)
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_post
      @admin_post = Admin::Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_post_params
      params.require(:admin_post).permit(:attachment, :content, :store_id)
    end
end
