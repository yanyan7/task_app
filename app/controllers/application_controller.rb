class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_action :login_required

  private

    # ユーザーのセッションを永続的にする
    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          session[:user_id] = user.id
          @current_user = user
        end
      end
    end

    def login_required
      redirect_to login_url unless current_user
    end
    
    # 永続的セッションを破棄する
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
    
    def admin_required
      if !current_user.admin?
        flash[:danger] = "管理者のみ利用可能な機能です"
        redirect_to root_url
      end
    end
end
