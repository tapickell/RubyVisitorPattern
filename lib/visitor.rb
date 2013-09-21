class Task
  attr_reader :name, :subtasks
  def initialize(name)
    @name = name
    @subtasks = []
    @completed = false
  end

  def completed?
    @completed && subtasks_completed?
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

  def accept_visitor(visitor)
    visitor.visit self
  end
end

class Visitor
  def visit(subject)
    "Task: #{subject.name}, Subtask Count: #{subject.count_subtasks}"
  end
end
