class TasksController < ApplicationController
  before_action :require_user_logged_in
  

  
  
  
  def index
    @tasks=current_user.tasks.all
  end
  
  def show
    @task=current_user.tasks.find(params[:id])
  end
  
  def new
    @task=current_user.tasks.new
  end
  
  def create
    @task=current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = "Taskが正常に投稿されました。"
      redirect_to @task
    else
       flash.now[:danger] = "Taskが投稿されませんでした。"
       render :new
    end
  end
  
  def edit
    @task=current_user.tasks.find(params[:id])
  end
  
  def update
    @task=current_user.tasks.find(params[:id])
    
    if @task.update(task_params)
      flash[:success]="Taskは正常に更新されました。"
      redirect_to @task
    else
      
      flash.now[:danger]="Taskは更新されませんでした。"
      render :edit
      

    end
  end
  
  def destroy
    @task=current_user.tasks.find(params[:id])
    @task.destroy
    
    flash[:success] = "Taskは正常に削除されました。"
    redirect_to tasks_url
  end
  
  
  
  
  private

def task_params
  params.require(:task).permit(:content, :status)
end
  
end

