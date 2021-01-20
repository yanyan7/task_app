class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      remember user
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render "new"
    end
  end

  def destroy
    forget(current_user)
    reset_session
    # @current_user = nil
    logger.debug("session[:user_id]: #{session[:user_id]}")
    logger.debug("cookies.signed[:user_id]: #{cookies.signed[:user_id]}")
    logger.debug("cookies.signed[:remember_token]: #{cookies.signed[:remember_token]}")

    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end
