class BooksController < ApplicationController
  # Authenticate user before certain actions
  
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    root_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # Redirect to the homepage after sign-out
  end
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    # @book.user = current_user  # Associate the book with the signed-in user

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_name, :description)
  end
end
