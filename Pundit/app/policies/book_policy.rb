class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user.admin? || book.user == user
  end

  def destroy?
    user.admin? || book.user == user
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
