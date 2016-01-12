class PostsController < ApplicationController
  before_action :facecontrol

  def index
    @posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 5)
  end

  def personal_blog
    @user = User.find_by name: params[:name]
    @posts = @user.posts.order(id: :desc).paginate(page: params[:page], per_page: 5)
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
    @parent_comments = @post.comments.select {|comment| comment.parent.nil? }
    @new_comment = Comment.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes post_params
      flash[:success] = 'Post updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :password_confirmation, :avatar)
  end
end
