class SearchController < ApplicationController
  # 検索機能を追加（searchアクション）
  def search
    @word = params[:word]
    @path = params[:path]
    match = params[:match]
    case params[:path]
    when "books"
      @books = Book.search(@word, match)
    when "users"
      @users = User.search(@word, match)
    else
    end
  end
end
