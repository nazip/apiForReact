class CommentController < ApplicationController
  before_action :set_default_response_format

  def create
    @comment = Comment.new
    @comment.txt = params[:comment]
    @comment.post_id = params[:post_id]
    @comment.save
    respond_to do |format|
      format.html
      format.json {render json: @comment}
    end
  end

 private

  def set_default_response_format
    request.format = :json
  end

end
