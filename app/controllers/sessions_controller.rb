class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render "new"
    end
  end

  def destroy
    reset_session
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end
