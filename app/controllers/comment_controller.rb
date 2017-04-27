class CommentController < ApplicationController
  before_action :set_default_response_format

  def create
    @comment = Comment.new
    @comment.txt = params[:comment]
    @comment.post_id = params[:post_id]
    @comment.save
    @comments = Comment.select('id, post_id, txt as comment').where('post_id = ?', params[:post_id])
    respond_to do |format|
      format.html
      format.json {render json: @comments}
    end
  end

 private

  def set_default_response_format
    request.format = :json
  end

end
