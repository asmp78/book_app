# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  # GET /books
  def index
    @books = Book.where(user_id: current_user.followings).or(Book.where(user_id: current_user)).page(params[:page])
  end

  # GET /books/1
  def show
    @comments = @book.comments
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = current_user.books.find(params[:id])
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book, notice: t("flash.notice.book.create")
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book = current_user.books.find(params[:id])
      @book.update(book_params)
      redirect_to @book, notice: t("flash.notice.book.update")
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy
    redirect_to books_url, notice: t("flash.notice.book.destroy")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end
end
