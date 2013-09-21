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
    before(:each) do
      @task << Task.new('Subtask One')
      @task << Task.new('Subtask Two')
    end

    it 'adds tasks to the subtasks array' do
      @task.subtasks.first.name.should == 'Subtask One'
    end

    it 'returns the number of subtasks' do
      @task.count_subtasks.should == 2
    end
  end

  describe 'task completion' do
    before(:each) do
      @task << Task.new('Subtask One')
      @task << Task.new('Subtask Two')
    end

    it 'returns false if any subtasks are not completed' do
      @task.subtasks.each { |task| task.complete }
      @task.complete
      @task.completed?.should == true
    end

    it 'returns true if all subtasks are complete and task is complete' do
      @task.complete
      @task.completed?.should == false
    end
  end
end

describe Visitor do

end
