class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
      @user = User.find(params[:id])
      unless @user == current_user
      redirect_to user_path(current_user)
      end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(user)
    else
      @user = User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @users = User.find(params[:id])
    @books = @users.books
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
