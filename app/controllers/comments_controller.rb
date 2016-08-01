class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  respond_to :js
  


  def create
    @comment = @commentable.comments.new do |comment|
      comment.comment = params[:comment_text]
      comment.user = current_user
    end

      @comment.save
      
      @user=current_user
      @friends = @comment.commentable.user.user_followers#@user.user_followers
       if @friends.include?(current_user)
      #   # @friends.delete(current_user)
       end  
      
      for friend in @friends
        Pusher['private-'+friend.id.to_s].trigger('greet', {
          :comment =>@comment
        })
      end

      respond_to do |format|
        format.js
        format.html { redirect_to root_path }
      end
    

  end

  def shownolayout
    @comment=Comment.find(params[:id])
    @commentable_type=@comment.commentable_type
    @commentable=@comment.commentable
    render "shownolayout", layout: false
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  private
  def find_commentable
    @commentable_type = params[:commentable_type].classify
    @commentable = @commentable_type.constantize.find(params[:commentable_id])
  end
end
