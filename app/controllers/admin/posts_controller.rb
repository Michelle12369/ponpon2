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
  # def new
  #   @admin_post = Admin::Post.new
  # end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  # POST /admin/posts.json
  def create
    @admin_post = @current_store.posts.new(admin_post_params)
    
      if @admin_post.save
        respond_to do |format|
          @admin_activity=@admin_post.create_activity(:create, :owner => @current_store)
          format.html { redirect_to admin_posts_path, notice: '已成功張貼文章' }
          format.js
        end
      else
        # format.html { render :new }
        # format.json { render json: @admin_post.errors, status: :unprocessable_entity }
         redirect_to admin_posts_path, alert: @admin_post.errors.full_messages.first
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
    @week_followers=Follow.where(followable_type:"Store",followable_id:@current_store)
    @store_posts=Post.includes(:comments).where("store_id=?",@current_store).order(created_at: :desc)
    @agexaxis=["18歲以下","18~24歲","25~32歲","33~40歲","41~48歲","49~55歲","56~60歲","60歲以上"]
    @genderxaxis=["男性","女性"]
    @ages_vote=[0,0,0,0,0,0,0,0]
    @ages_comment=[0,0,0,0,0,0,0,0]
    @gender_comment=[0,0]
    @gender_vote=[0,0]

    @store_posts.each do |x|
      #vote
      x.votes_for.up.each do |vote|
        cal_gender(vote.voter.gender,@gender_vote)
        cal_age(vote.voter.age,@ages_vote)
      end
      #comment
      x.comments.each do |y| 
        if !y.user.nil?
          cal_gender(y.user.gender,@gender_comment)
          cal_age(y.user.age,@ages_comment)
        end
      end     
    end
    #follow
    @age_follow=[0,0,0,0,0,0,0,0]
    @gender_follow=[0,0]
    @week_followers.each do |follow|
      cal_gender(follow.follower.gender,@gender_follow)
      cal_age(follow.follower.age,@age_follow)
    end
  end


  private
    def cal_gender(user_gender,cal_array)
      if user_gender=="male"
        cal_array[0]+=1
      else
        cal_array[1]+=1
      end
    end
    
    def cal_age(user_age,cal_array)
      if user_age<18
        cal_array[0]+=1
      elsif user_age<25
        cal_array[1]+=1
      elsif user_age<33
        cal_array[2]+=1
      elsif user_age<41
        cal_array[3]+=1
      elsif user_age<49
        cal_array[4]+=1
      elsif user_age<56
        cal_array[5]+=1
      elsif user_age<60
        cal_array[6]+=1
      else
        cal_array[7]+=1
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_post
      @admin_post = Admin::Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_post_params
      params.require(:admin_post).permit(:attachment, :content, :store_id)
    end
end
