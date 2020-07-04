# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /comments
  def index
    @comments = @commentable.comments
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = @commentable.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t("flash.notice.comment.create")
    else
      render :index
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t("flash.notice.comment.update")
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t("flash.notice.comment.destroy")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
