class FavoritesController < ApplicationController
  def create
    # favorite viewに飛ばすので、@をつける
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # 直線の画面に戻るリダイレクト（＋できなかった場合のパス）
    # redirect_back(fallback_location: books_path)
    # 非同期通信にするためコメントアウト
  end

  def destroy
    # favorite viewに飛ばすので、@をつける
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # 直線の画面に戻るリダイレクト（＋できなかった場合のパス）
    # redirect_back(fallback_location: books_path)
    # 非同期通信にするためコメントアウト
  end

end
