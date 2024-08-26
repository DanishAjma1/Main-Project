class BooksController < ApplicationController
  # http_basic_authenticate_with name: "dani", password: "secret", except: [ :index, :show ]

  # before_action :authenticate_user!
  # before_action :require_admin, only: [ :destroy ]
  # load_and_authorize_resource
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
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    if can?(:update, @book)
    @book = Book.find(params[:id])
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
    if can?(:destroy, @book)
    @book = Book.find(params[:id])
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
