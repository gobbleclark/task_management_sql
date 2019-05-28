class Board < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :lists, dependent: :destroy

  def self.single_board(user_id, board_id)
    Board.find_by_sql(["
      SELECT * 
      FROM boards AS b
      WHERE b.id = ? AND b.user_id = ?
    ", board_id, user_id]).first
  end

      def self.all_boards(user_id)
        Board.find_by_sql("
          SELECT *
          FROM boards AS b
          WHERE b.user_id = #{user_id}
          
          ")
      end 

      def self.create_board(p, user_id)
        Board.find_by_sql(["
          INSERT INTO boards (name, user_id, created_at, updated_at)
          VALUES (:name, :user_id, :created_at, :updated_at);
        ", {
            name: p[:name],
            user_id: user_id,
            created_at: DateTime.now,
            updated_at: DateTime.now
      
        }])
      end 

      def self.update_board(board_id, p)
        Board.find_by_sql(["
          UPDATE boards AS b
          SET name = ?
          WHERE b.id = ?
        ;", p[:name], DateTime.now, board_id])
      end

      def self.delete_board(board_id)
        Board.find_by_sql(["
          DELETE FROM boards AS b
          WHERE b.id = ?
        ;", board_id])
      end

      def self.get_lists_and_tasks(board_id)
          find_by_sql (["
            select *
            from boards
            left join lists
            on boards.id = lists.board_id
            left join tasks
            on lists.id = tasks.list_id
            where boards.id = ?
           ",board_id])
      end

end
