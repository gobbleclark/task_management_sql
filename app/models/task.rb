class Task < ApplicationRecord
  belongs_to :list

  def self.single_task(list_id, task_id)
    Task.find_by_sql(["
      SELECT * 
      FROM tasks AS t
      WHERE t.id = ? AND t.list_id = ?
    ", task_id, list_id]).first
  end

  def self.all_tasks(list_id)
    Task.find_by_sql("
      SELECT *
      FROM tasks AS t
      WHERE t.list_id = #{list_id}
      
      ")
  end 

  def self.create_task(p, list_id)
    Task.find_by_sql(["
      INSERT INTO tasks (name, description, list_id, created_at, updated_at)
      VALUES (:name, :description, :list_id, :created_at, :updated_at);
    ", {
        name: p[:name],
        description: p[:description],
        list_id: list_id,
        created_at: DateTime.now,
        updated_at: DateTime.now
  
    }])
  end 

  def self.update_task(task_id, p)
    Task.find_by_sql(["
      UPDATE tasks AS t
      SET name = ?
      WHERE t.id = ?
    ;", p[:name], DateTime.now, task_id])
  end

  def self.delete_task(task_id)
    Task.find_by_sql(["
      DELETE FROM tasks AS t
      WHERE t .id = ?
    ;", task_id])
  end




end
