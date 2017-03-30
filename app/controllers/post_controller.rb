class PostController < ApplicationController

  before_action :set_default_response_format

  def index
# byebug
    # if params[:PageNumber] != nil and params[:PageSize]  != nil
    #   @posts = Post.all
    #           .offset(
    #             params[:PageNumber].to_i * params[:PageSize].to_i)
    #           .limit(params[:PageSize].to_i)
    # else
    #   @posts = Post.all
    # end

    @pageSize = params[:pageSize].to_i < 1 ? 1 : params[:pageSize].to_i

    @posts = Post.all.offset(params[:activePage].to_i*@pageSize).limit(@pageSize)
    @r = []
    @posts.each do |post|
      @r <<  {image: {
              src: post.image_src,
              alt: post.image_alt,
              width: post.image_width,
              height: post.image_height,
             },
             metadata: {
              author: post.metadata_author,
              # like: post.metadata_like,
              updatedAt: post.metadata_updated_at,
              createdAt: post.metadata_created_at
             },
             txt: post.txt,
             id: post.id
           }
    end

    respond_to do |format|
      format.html
      format.json {render json:
        {entries: @r,
          pagination: {
            activePage: params[:activePage].to_i,
            pageSize: @pageSize,
            pageCount: Post.count % @pageSize > 0 ? (Post.count/@pageSize).to_i+1 : (Post.count/@pageSize).to_i
          }
        }
      }
    end
  end

  def show
# byebug
    # @r = []
    @post = Post.find(params[:id])
      @r =  {image: {
              src: @post.image_src,
              alt: @post.image_alt,
              width: @post.image_width,
              height: @post.image_height,
             },
             metadata: {
              author: @post.metadata_author,
              # like: @post.metadata_like,
              updatedAt: @post.metadata_updated_at,
              createdAt: @post.metadata_created_at
             },
             txt: @post.txt,
             id: @post.id
           }
    respond_to do |format|
      format.html
      format.json {render json: @r}
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.metadata_like ||= 0
    @post.metadata_like = @post.metadata_like + 1
    @post.save
    respond_to do |format|
      format.html
      format.json {render json: ''}
    end
  end

  def like
# byebug
    @post = Post.find(params[:id])
    @post.metadata_like = 0 if @post.metadata_like == nil
    @post.metadata_like = @post.metadata_like + 1
    @post.save
      @r =  {image: {
              src: @post.image_src,
              alt: @post.image_alt,
              width: @post.image_width,
              height: @post.image_height,
             },
             metadata: {
              author: @post.metadata_author,
              like: @post.metadata_like,
              updatedAt: @post.metadata_updated_at,
              createdAt: @post.metadata_created_at
             },
             txt: @post.txt,
             id: @post.id
           }
    respond_to do |format|
      format.html
      format.json {render json: @r}
    end
  end

  def page
    byebug

  end

protected

  def set_default_response_format
    request.format = :json
  end

end
