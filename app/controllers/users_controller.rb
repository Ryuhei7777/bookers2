class UsersController < ApplicationController
    before_action :authenticate_user!
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end
  
  def show
    @user = Book.find(params[:id]).user
    @book = Book.new
    @users = User.find(params[:id])
    @books = @users.books
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
