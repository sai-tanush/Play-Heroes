class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :authorize_user, only: [:edit, :update, :destroy]

    def index
      @posts = Post.includes(:user).order(created_at: :desc)
    end

    def show
    end

    def new
      @post = current_user.posts.build
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to moments_path, notice: "Post created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to moments_path, notice: "Post updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
        @post = Post.find(params[:id])

        if @post.user == current_user
          @post.destroy
          redirect_to posts_path, notice: "Post deleted successfully."
        else
          redirect_to posts_path, alert: "You are not authorized to delete this post."
        end
    end

    def like
      @post = Post.find(params[:id])
      @like = @post.post_likes.find_by(user: current_user)

      if @like
        @like.destroy
      else
        @post.post_likes.create(user: current_user)
      end

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "like_section_#{@post.id}",
            partial: 'posts/like_section',
            locals: { post: @post }
          )
        }
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:description, :media)
    end

    def authorize_user
      unless @post.user == current_user
        redirect_to moments_path, alert: "You can only modify your own posts."
      end
    end
  end
