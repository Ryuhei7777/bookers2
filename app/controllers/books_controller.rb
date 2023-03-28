class BooksController < ApplicationController
  before_action :authenticate_user!
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
    @book.save
    redirect_to book_path(@book)
  end



   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
