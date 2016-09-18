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
    @last_sunday=(DateTime.now-DateTime.now.wday).to_date
    @last_last_sunday=@last_sunday-7
    @week_followers=Follow.recent(@last_last_sunday).where(followable_type:"Store",followable_id:@current_store).size-Follow.recent(@last_sunday).where(followable_type:"Store",followable_id:@current_store).size
    @store_posts=Post.includes(:comments).where("store_id=? and created_at<=? and created_at>=?",@current_store,@last_sunday,@last_last_sunday).order(created_at: :desc)
    # Comment.joins(:post).where(post: @store_posts)
    @agexaxis=["18歲以下","18~24歲","25~32歲","33~40歲","41~48歲","49~55歲","56~60歲","60歲以上"]
    @locationxaxis=["基隆市","台北市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","台東縣","花蓮縣","宜蘭縣","澎湖縣","金門縣","連江縣"]
    @genderxaxis=["男性","女性"]
    @ages=[0,0,0,0,0,0,0,0]
    @location=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @gender=[0,0]
    @store_posts.each do |x|
      x.comments.each do |y| 
        if !y.user.nil?
          user_age=y.user.age
          user_location=y.user.location if !y.user.location.nil?
          user_gender=y.user.gender
            if user_age<18
              @ages[0]+=1
            elsif user_age<25
              @ages[1]+=1
            elsif user_age<33
              @ages[2]+=1
            elsif user_age<41
              @ages[3]+=1
            elsif user_age<49
              @ages[4]+=1
            elsif user_age<56
              @ages[5]+=1
            elsif user_age<60
              @ages[6]+=1
            else
              @ages[7]+=1
            end
            if user_gender=="male"
              @gender[0]+=1
            else
              @gender[1]+=1
            end
        end
      end  
    end 
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
