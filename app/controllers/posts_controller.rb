class PostsController < ApplicationController

  def index
    @posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find params[:id]
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :password_confirmation, :avatar)
    end
end
