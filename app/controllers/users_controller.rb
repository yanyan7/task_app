class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :admin_required, only: [:index]
  before_action :correct_user_required, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "登録しました"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "登録しました"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "退会しました"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user_required
      if !current_user.admin? && params[:id].to_i != current_user.id.to_i
        flash[:danger] = "管理者のみ利用可能な機能です"
        redirect_to root_url
      end
    end
end
