class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  def index
    @boards = Board.all_boards(current_user.id)
  end

  def show
    @cards = Board.get_lists_and_tasks(params[:id])
  end

  def new
    @board = current_user.boards.new
  end

  def create
   
    @board = Board.create_board(board_params, current_user.id)
    redirect_to boards_path
  end 

  def edit

  end

  def update
    @board = Board.update_board(@board.id, board_params)
    redirect_to boards_path
  end

  def destroy
    @board = Board.delete_board(@board.id)
    redirect_to boards_path
  end 


  private 
  def set_board
    @board = Board.single_board(current_user.id , params[:id])
  end

  def board_params
    params.require(:board).permit(:name)
  end


end
