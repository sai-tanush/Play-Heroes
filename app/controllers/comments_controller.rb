class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :set_comment, only: [:destroy]
    before_action :authorize_comment, only: [:destroy]
  
    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?
  
      respond_to do |format|
        if @comment.save
          format.turbo_stream
          format.html { redirect_to root_path }
        else
          format.html { redirect_to root_path, alert: 'Error posting comment.' }
        end
      end
    end
  
    def destroy
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
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
  