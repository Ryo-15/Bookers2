class ApplicationController < ActionController::Base
  # ログイン認証されていなければ、ログイン画面へリダイレクトする
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  #sign_up時の登録情報追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :postcode, :prefecture_code, :address_city, :address_street])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name]) # ログイン時はnameを使用
  end

  # サインイン後の画面遷移
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  # 新規登録後の画面遷移
  def after_sign_up_path_for(resource)
    user_path(current_user.id)# ,notice:"Welcome! You have signed up successfully."
  end

  def after_sign_out_path_for(resorce)
    root_path
  end

end
