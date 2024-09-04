class Api::V1::BooksController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [ :create, :update, :destroy ]
  # before_action :authorize_post, only: [ :edit, :update, :destroy ]
  # before_action :authenticate_user!, unless: -> { Rails.env.test? }
  before_action :set_book, only: [ :show, :update, :destroy ]

  def index
    @books = current_user.books
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  private

  def set_book
    @book = current_user.books.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Book not found' }, status: :not_found
  end

  def book_params
    params.require(:book).permit(:title, :author_name, :description, :published_date)
  end
end
