class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_list
  before_action :set_board
  def index
    @tasks = Task.all_tasks(@list)
  end

  def show
  end

  def create
    @task = Task.create_task(task_params, @list.id)
    redirect_to board_list_tasks_path(@board, @list)
  end
  
  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def update
    @task = Task.update_task(@task.id, task_params)
  end

  def destroy
    @task = Task.delete_task(@task.id)
    redirect_to board_list_tasks_path(@board, @list)
    
  end

  private
  def set_task
    @task = Tsk.single_board(@list.id , params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_list
    @list = List.single_list(@board, params[:id])
  end

  def task_params
    params.require(:name).permit(:name, :description)
  end 
end
