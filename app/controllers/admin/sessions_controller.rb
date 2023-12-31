class Admin::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in)
  end

  # ログイン後のページ遷移先
  def after_sign_in_path_for(resource)
      admin_users_path
  end

  # ログアウト後のページ遷移先
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end