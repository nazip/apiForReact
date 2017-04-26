class PostController < ApplicationController
   before_action :set_default_response_format

  def index
    @pageSize = params[:pageSize].to_i < 1 ? 1 : params[:pageSize].to_i

    @posts = Post.all.offset(params[:activePage].to_i*@pageSize).limit(@pageSize)
    # @posts = Post.left_outer_joins(:comments).select('posts.*, comments.txt as comment').offset(params[:activePage].to_i*@pageSize).limit(@pageSize)
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
              like: post.metadata_like,
              updatedAt: post.metadata_updated_at,
              createdAt: post.metadata_created_at
             },
             txt: post.txt,
             id: post.id
           }
    end

    @comments = Comment.all
    @com = []
    @comments.each do |comment|
      @com << {post_id: comment.post_id, comment: comment.txt }
    end

    respond_to do |format|
      format.html
      format.json {render json:
        {entries: @r,
          pagination: {
            activePage: params[:activePage].to_i,
            pageSize: @pageSize,
            pageCount: Post.count % @pageSize > 0 ? (Post.count/@pageSize).to_i+1 : (Post.count/@pageSize).to_i
          },
          comments: @com
        }
      }
    end
  end

  def show
# byebug
    # @r = []
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: prepareData(@post)}
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.metadata_author = params[:item][:author]
    @post.txt = params[:item][:title]
    @post.save
    respond_to do |format|
      format.html
      format.json {render json: prepareData(@post)}
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.metadata_like = 0 if @post.metadata_like == nil
    @post.metadata_like = @post.metadata_like + 1
    @post.save
    respond_to do |format|
      format.html
      format.json {render json: prepareData(@post)}
    end
  end

  def create
    @post = Post.new
    @post.metadata_author = params[:item][:author]
    @post.txt = params[:item][:title]
    @post.metadata_created_at = params[:item][:createdAt]
    @post.save
    respond_to do |format|
      format.html
      format.json {render json: prepareData(@post)}
    end
  end

protected
  def prepareData post
    @r =  {image: {
            src: post.image_src,
            alt: post.image_alt,
            width: post.image_width,
            height: post.image_height,
           },
           metadata: {
            author: post.metadata_author,
            like: post.metadata_like,
            updatedAt: post.metadata_updated_at,
            createdAt: post.metadata_created_at
           },
           comment: [],
           txt: post.txt,
           id: post.id
         }
  end

  def set_default_response_format
    request.format = :json
  end

end
