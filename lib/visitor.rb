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
end

class Visitor

end
