class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :update, :destroy]
  # 画面遷移防止(URL直打ち防止)
  before_action :correct_user, only: [:edit, :update]

  # トップページ
  def top
  end

  # 投稿された本の一覧
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  # 本の新規投稿
  def new
    @book = Book.new
  end

  # 新規投稿の保存
  def create
    @user = User.find(current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to ("/books/#{@book.id}"),notice:'You have creatad book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  # 投稿された本の詳細
  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  # 投稿された本の編集
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice:'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to user_path(), notice: "Book was successfully destroyed"
  end

  #画面遷移防止のため、定義
  def correct_user
    # bookについているidを呼び出し
    book = Book.find(params[:id])
    # カレントユーザーとbookのユーザーのidが不一致であればbook_pathへ
    if current_user != book.user
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
