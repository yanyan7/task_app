class TasksController < ApplicationController
  before_action :correct_task_required, only: [:show, :edit, :update, :destroy]
  
  def index
    if current_user.admin?
      @tasks = Task.all
    else
      @tasks = Task.all.where(user_id: current_user.id)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:success] = "登録しました"
      redirect_to @task
      # redirect_to task_url(@task)    #  上のはこれでも良い
    else
      render "new"
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.user_id = current_user.id
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to @task
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def correct_task_required
      user_id = Task.find(params[:id]).user_id
      if !current_user.admin? && user_id.to_i != current_user.id.to_i
        flash[:danger] = "管理者のみ利用可能な機能です"
        redirect_to root_url
      end
    end
end
