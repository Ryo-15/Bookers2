class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :show, :edit, :update, :destroy]
  # 画面遷移防止(URL直打ち防止)
  before_action :correct_user, only: [:edit, :update]

  # user一覧（Users画面になる）
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  # user詳細画面（Home画面になる）
  def show
    # ユーザのデータを1件取得し、インスタンス変数へ渡す
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  # プロフィール編集
  def edit
    @user = User.find(params[:id])
  end

  # プロフィール編集を保存
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice:'You have updated user successfully.'
    else
      render :edit
    end
  end

  # follow（自分がフォローした人のview）
  def follows
    @user = User.find(params[:id])
  end

  # followers（自分をフォローした人のview）
  def followers
    # 自分をフォローした人のidを引っ張る(viewにて記述)
    @user = User.find(params[:id])
  end

  # 他の人が編集できないようにする、before_acttionに繋がる
  def correct_user
    user = User.find(params[:id])
    # もしユーザーがカレントユーザーと不一致
    if current_user != user
      # カレントユーザーのユーザーパスへリダイレクト
      redirect_to user_path(current_user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
