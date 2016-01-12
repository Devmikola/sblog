class CommentsController < ApplicationController
  before_action :facecontrol

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(parent_id: params[:parent_id], post_id: params[:post_id], user_id: current_user.id,
                           text: comment_params[:text])
    if @comment.save
      redirect_to post_path params[:post_id]
    else
      render 'new' # Что !?)) что здесь нужно разместить - эксепшн ?
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end
end
