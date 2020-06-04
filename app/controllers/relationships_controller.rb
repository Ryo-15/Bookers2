class RelationshipsController < ApplicationController
  # follow
  def create
    current_user.follow(params[:id])
    # 直前の画面にリダイレクト
    redirect_back(fallback_location: books_path)
  end

  # unfollow
  def destroy
    current_user.unfollow(params[:id])
    # 直前の画面にリダイレクト
    redirect_back(fallback_location: books_path)
  end

end
