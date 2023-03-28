class UsersController < ApplicationController
    before_action :authenticate_user!
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
  end

  def show
    @user = Book.find(params[:id]).user
    @book = Book.new
    @users = User.find(params[:id])
    @books = @users.books
  end
end
