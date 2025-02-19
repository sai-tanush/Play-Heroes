class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @posts = Post.all.order(created_at: :desc)
    end
  
    def show
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to @post, notice: "Post created successfully!"
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: "Post updated successfully!"
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully!"
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:description, :media_url)
    end
  end
  