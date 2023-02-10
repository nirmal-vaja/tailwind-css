class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = current_user.posts.all
  end

  def show
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.join(' ')
      redirect_to new_post_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post Successfully updated"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.join(' ')
      redirect_to edit_post_path(@post.id)
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post destroyed successfully"
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages
      redirect_to posts_path
    end
  end

  private 

  def find_post
    @post = current_user.posts.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
