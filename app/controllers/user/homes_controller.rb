class User::HomesController < ApplicationController
  def top
  end

  def about
  end

  #   #ゲストユーザーはマイページ画面に遷移
  # def guest_sign_in
  #   user = User.guest
  #   sign_in user
  #   redirect_to user_mypage_path, notice: "guestuserでログインしました。"
  # end

end
