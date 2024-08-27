class ReviewsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource
  def create
   @book = Book.find(params[:book_id])
  @review = @book.reviews.build(review_params) # Use .build to instantiate the review
  @review.user= current_user
    if @review.save
      redirect_to @book, notice: "Review was successfully created."
    else
      redirect_to @book, alert: "Unable to create review."
    end
  end
   def update
     @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])
    if can?(:update, @review)
      if @review.update(review_params)
        redirect_to @review.book, notice: "Review was successfully updated."
      else
        render :edit
      end
    else
      redirect_to @review.book, notice: "Access denied: You don't have permission to update this review."
    end
  end

  def destroy
     @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])

    if can?(:destroy, @review)
      @review.destroy
      # redirect_to @review.book, notice: "Review was successfully destroyed."
    else
      redirect_to books_url, notice: "Access denied: You don't have permission to destroy this review."
    end
  end
    def edit
      @book = Book.find(params[:book_id])
      @review = Review.find(params[:id])
    end

    private
    def review_params
      params.require(:review).permit(:reviewer, :msg)
    end
end
