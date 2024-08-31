class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def show
    authorize @book
  end

  def new
    @book = Book.new
    authorize @book
  end

  def create
    @book = current_user.books.build(book_params)
    authorize @book
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @book
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to books_url, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_name, :description)
  end
end
