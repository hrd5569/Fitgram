# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  #ゲストユーザーはマイページ画面に遷移
  def guest_sign_in
    user = User.guest
    sign_in user

    redirect_to posts_path(user), notice: "guestuserでログインしました。"
  end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
   end

   #ログイン後のページ遷移先
   def after_sign_in_path_for(resource)
    posts_path
   end

   #ログアウト後のページ遷移先
   def after_sign_out_path_for(resource)
    root_path
   end

end