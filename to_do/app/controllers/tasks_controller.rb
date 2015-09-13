class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    redirect_to '/tasks'
  end

  def edit
    @task = Task.find(params[:id])
  end

    def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to '/tasks'
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task deleted successfully'
    redirect_to '/tasks'
  end

  def task_params
    params.require(:task).permit(:name)
  end
end