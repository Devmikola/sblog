class CommentsController < ApplicationController
  before_action :facecontrol

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(parent_id: params[:parent_id], post_id: params[:post_id], user_id: current_user.id,
                           text: comment_params[:text])
    if (params[:parent_id].nil? || Comment.find(params[:parent_id]).text) && @comment.save
      render json: { new_comment: render_to_string(partial: 'comments/build_comments_tree', locals: {input_comments: [@comment]}), comment_id: @comment.id }
    else
      Rails.logger.debug "Trying to answer to deleted comment by user with id: #{current_user.id}\n"
      render nothing: true
    end
  end

  def edit
    @comment = Comment.find params[:comment_id]
  end

  def update
    @comment = Comment.find params[:comment_id]
    if current_user.id == @comment.user.id && !@comment.text.nil? && @comment.update_attributes(comment_params)
      #flash[:success] = 'Comment updated'
      #redirect_to @post
      #render nothing: true
      render json: {updated_at: @comment.updated_at.strftime('%I:%M %b %d %Y') }
    else
      raise Error
      #render 'edit'
    end
  end

  def destroy
    @comment = Comment.find params[:comment_id]
    if current_user.id == @comment.user.id && @comment.update_attribute(:text, nil)
      render json: {result: 'success', deleted_at: @comment.updated_at.strftime('%I:%M %b %d %Y')}
    else
      render json: {result: 'failure'}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text)
    end
end
