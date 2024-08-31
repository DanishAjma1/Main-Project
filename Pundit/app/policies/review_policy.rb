class ReviewPolicy
  attr_reader :user, :review

  def initialize(user, review)
    @user = user
    @review = review
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? # Any logged-in user can create a review
  end

  def update?
    user.admin? || review.user == user
  end

  def destroy?
    user.admin? || review.user == user
  end
  def edit?
    update? # If you can update, you can edit
  end
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
