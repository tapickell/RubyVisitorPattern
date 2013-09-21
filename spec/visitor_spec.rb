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

    it 'returns true if all subtasks are complete and task is complete' do
      @task.subtasks.each { |task| task.complete }
      @task.complete
      @task.completed?.should == true
    end

    it 'returns false if all subtasks are completed but the task is not set to completed' do
      @task.subtasks.each { |task| task.complete }
      @task.completed?.should == false
    end

    it 'returns false if any subtasks are not completed' do
      @task.complete
      @task.completed?.should == false
    end
  end

  describe 'visitor acceptance' do
    it 'takes a visitor object and calls visit passing self' do
      @visitor = double('Visitor')
      @visitor.stub(:visit)
      @visitor.should_receive(:visit).with(@task)
      @task.accept_visitor(@visitor)
    end

    it 'works with a StringVisitor' do
      @task << Task.new('Subtask One')
      @task.accept_visitor(StringVisitor.new()).should == 'Task: Task One, Subtask Count: 1'
    end

    it 'works with a HashVisitor' do
      @subtask = Task.new('Subtask One')
      @task << @subtask
      @task.accept_visitor(HashVisitor.new()).should == {:name => 'Task One', :subtasks => [@subtask]}
    end
  end
end

describe StringVisitor do
  before(:each) do
    @visitor = StringVisitor.new
  end

  describe 'visit' do
    it 'returns a string with the subject name and number of subtasks' do
      @task = double('Task')
      @task.stub(:name).and_return('Task One')
      @task.stub(:count_subtasks).and_return(2)
      @visitor.visit(@task).should == 'Task: Task One, Subtask Count: 2'
    end
  end
end

describe HashVisitor do
  before(:each) do
    @visitor = HashVisitor.new
  end

  describe 'visit' do
    it 'returns a hash with the subject name and subtasks' do
      @task = double('Task')
      @subtask_one = double('Subtask One')
      @subtask_two = double('Subtask Two')
      @task.stub(:name).and_return('Task One')
      @task.stub(:subtasks).and_return([@subtask_one, @subtask_two])
      @visitor.visit(@task).should == {:name => 'Task One', :subtasks => [@subtask_one, @subtask_two]}
    end
  end
end
