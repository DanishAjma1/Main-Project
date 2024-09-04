class BooksController < ApplicationController
  # http_basic_authenticate_with name: "dani", password: "secret", except: [ :index, :show ]
  before_action :authenticate_user!
  # before_action :require_admin, only: [ :destroy ]
  # load_and_authorize_resource
  # before_action :find_book, only: [ :show, :edit, :update, :destroy ]

  include Pagy::Backend
  def index
    if params[:query].present?
      @pagy, @books = pagy(Book.search_books(params[:query]))
    else
      @pagy, @books = pagy(Book.all)
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)  # Associates the book with the current user
    if @book.save
      UserMailer.reset_password_instructions.deliver_now
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if can?(:update, @book)
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit
    end
    else
    redirect_to book_path, notice: "Access denied: You don't have permission to update this post."
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if can?(:destroy, @book)
    @book.destroy
    redirect_to books_url, notice: "Book was successfully destroyed."
    else
        redirect_to books_url, notice: "Access denied: You don't have permission to destroy this post."
    end
  end

  private

  # def require_admin
  #   unless current_user.admin?
  #     flash[:alert] = "Only admins can perform that action."
  #     redirect_to books_path
  #   end
  # end

  def book_params
    params.require(:book).permit(:title, :author_name, :description)
  end
end
