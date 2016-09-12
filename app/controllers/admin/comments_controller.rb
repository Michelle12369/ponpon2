class Admin::CommentsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  respond_to :js

  def create
    @comment = @commentable.comments.new do |comment|
      comment.comment = params[:comment_text]
      comment.store = @current_store
    end
    @comment.save
    respond_to do |format|
      format.js
      format.html { redirect_to admin_posts_path }
    end
  end

  def destroy
    @comment = @current_store.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to admin_posts_path }
    end
  end


  private
    def find_commentable
      @commentable_type = params[:commentable_type].classify
      @commentable = @commentable_type.constantize.find(params[:commentable_id])
    end
end
