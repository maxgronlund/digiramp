class ForumPostsController < ApplicationController
  before_action :set_forum_post, only: [:show, :edit, :update, :destroy]

  # GET /forum_posts
  # GET /forum_posts.json
  def index
    @forum_posts = ForumPost.all
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.json
  def show
  end

  # GET /forum_posts/new
  def new
    @forum_post = ForumPost.new
  end

  # GET /forum_posts/1/edit
  def edit
  end

  # POST /forum_posts
  # POST /forum_posts.json
  def create
    @forum_post = ForumPost.new(forum_post_params)

    respond_to do |format|
      if @forum_post.save
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully created.' }
        format.json { render :show, status: :created, location: @forum_post }
      else
        format.html { render :new }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forum_posts/1
  # PATCH/PUT /forum_posts/1.json
  def update
    respond_to do |format|
      if @forum_post.update(forum_post_params)
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_post }
      else
        format.html { render :edit }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.json
  def destroy
    @forum_post.destroy
    respond_to do |format|
      format.html { redirect_to forum_posts_url, notice: 'Forum post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum_post
      @forum_post = ForumPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_post_params
      params.require(:forum_post).permit(:title, :body, :image, :user_id, :forum_id, :uniq_likes, :published)
    end
end
