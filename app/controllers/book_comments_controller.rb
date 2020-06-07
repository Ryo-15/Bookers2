class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_new = Book.new
    @book_comment = current_user.book_comments.new(book_comment_params)
    # @book_comment = BookComment.new(book_comment_params)
    # @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    # @book_comment.book_id = params[:book_id].to_i
    @book_comment.save
    @book_comments = Book.find(params[:book_id]).book_comments
    # 直線の画面に戻るリダイレクト（＋できなかった場合のパス）
    # redirect_back(fallback_location: books_path)
    # 非同期通信にするためコメントアウト
  end

  def destroy
    @book_comment = BookComment.find(params[:book_id])
    @book_comment.destroy
    @book_comments = Book.find(@book_comment.book_id).book_comments
    # 直線の画面に戻るリダイレクト（＋できなかった場合のパス）
    # redirect_back(fallback_location: books_path)
    # 非同期通信にするためコメントアウト
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
