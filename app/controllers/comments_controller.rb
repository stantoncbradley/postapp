class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.by_post_and_root(params[:post_id]).map(&:to_custom_hash)

    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    head :no_content
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params[:comment].permit(:user_id, :post_id, :parent_id, :content)
    end
end
