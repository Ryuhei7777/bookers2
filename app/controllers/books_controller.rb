class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = Book.find(params[:id]).user
    @book = Book.new
    @books = Book.find(params[:id])
  end

  def edit
    if Book.find(params[:id]) == current_user.books.id
    @book = Book.find(params[:id])
    else
      book =  current_user.books.id
      redirect_to book_path(book)
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
    else
      @book = Book.find(params[:id])
      @book.update(book_params)
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

   # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index

    end
  end



   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end

end
