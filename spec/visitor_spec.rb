require 'visitor'

describe Task do
  before(:each) do
    @task = Task.new('Task One')
  end

  describe 'initilization' do
    it 'initializes with a name' do
      @task.name.should == 'Task One'
    end

    it 'initializes with an empty set of subtasks' do
      @task.subtasks.should == []
    end

    it 'initializes not completed' do
      @task.completed?.should == false
    end
  end

  describe 'adding subtasks to parent task' do
    it 'adds tasks to the subtasks array' do
      @task << Task.new('Subtask One')
      @task.subtasks.first.name.should == 'Subtask One'
    end
  end
end

describe Visitor do

end
