class Task
  attr_reader :name, :subtasks
  def initialize(name)
    @name = name
    @subtasks = []
    @completed = false
  end

  def completed?
    @completed
  end

  def <<(task)
    @subtasks << task
  end

  def count_subtasks
    @subtasks.count
  end

  def complete
    @completed = true if subtasks_completed?
  end

  def subtasks_completed?
    @subtasks.collect{ |task| task.completed? }.all?
  end
end

class Visitor

end
