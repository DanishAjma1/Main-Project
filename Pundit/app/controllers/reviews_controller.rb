class ReviewsController < ApplicationController
 before_action :set_book
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!

  def index
    @reviews = policy_scope(@book.reviews)
  end

  def show
    authorize @review
  end

  def new
    @review = @book.reviews.build
    authorize @review
  end

  def create
    @review = @book.reviews.build(review_params)
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to book_path(@book), notice: "Review was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to book_path(@book), notice: "Review was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to book_path(@book), notice: "Review was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

    private
    def review_params
      params.require(:review).permit(:reviewer, :msg)
    end
end
