class SearchController < ApplicationController
  # 検索機能を追加（searchアクション）
  def search
    case params[:path]
    when "books"
      redirect_to Something_path # bookの検索結果画面へ
    when "users"
      redirect_to Something_path # userの検索結果画面へ
    else
    end
  end
end
