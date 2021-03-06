class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order("updated_at ASC")
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to task_path(@task), notice: "Your task has been created!"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task has been updated successfully!'
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was removed successfully'
  end

  private
    def task_params
      params.require(:task).permit(:name)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
