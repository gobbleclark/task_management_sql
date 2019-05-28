class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_board
  
  def index
    @lists = List.all_lists(@board.id)
  end

  def show
  end

  def new
    @list = @board.lists.new
  end
  
  def create
    List.create_list(list_params, @board.id)
    redirect_to board_list_path(@board.id, @list.id)
  end

  def edit
  end

  def update
    List.update_list(@list.id, list_params)
  end 

  def destroy
    List.delete_list(@list.id)
    redirect_to board_lists_path
  end

  private 
  def set_list
    @list = List.single_list(@board, params[:id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  

  def list_params
    params.require(:list).permit(:name)
  end


end
