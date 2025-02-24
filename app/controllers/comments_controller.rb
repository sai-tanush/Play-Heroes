class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :set_comment, only: [:destroy]
    before_action :authorize_comment, only: [:destroy]
  
    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?
  
      if @comment.save
        redirect_to moments_path, notice: "Comment added!"
      else
        redirect_to moments_path, alert: "Failed to add comment."
      end
    end
  
    def destroy
      @comment.destroy
      redirect_to moments_path, notice: "Comment deleted."
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def authorize_comment
      redirect_to moments_path, alert: "Not authorized!" unless @comment.user == current_user
    end
  
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
  end
  