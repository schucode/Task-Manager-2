require 'spec_helper'

describe 'Project' do

	before do
    @project = TM::Project.new("myproject")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "must have a name" do
  	expect(@project.name).to eq("myproject")
  end

  it "must have an id" do
  	expect(@project.id).to eq(2)
  end

  it "must create tasks with project id, description, and priority number" do
    TM::Task.stub(:all_tasks).and_return([])

    task = @project.add_task("do stuff", 4)

    expect(task.pro_id).to eq(@project.id)
    expect(task.description).to eq("do stuff")
    expect(task.priority).to eq(4)
    expect(TM::Task.all_tasks.length).to eq(1)
  end

  it "it must mark off tasks as completed" do
    TM::Task.stub(:all_tasks).and_return([])

    task = @project.add_task("do stuff", 4)

    expect(task.done_status).to eq(false)
    @project.finish_task(task.id)
    expect(task.done_status).to eq(true)
  end

  it "list completed tasks, sorted by creation date" do
    TM::Task.stub(:all_tasks).and_return([])

    task_one = @project.add_task("do stuff", 4)
    task_two = @project.add_task("do more stuff", 4)
    task_three = @project.add_task("do other stuff", 4)
    task_four = @project.add_task("nap", 4)

    expect(@project.get_complete_tasks).to eq([])

    @project.finish_task(task_one.id)
    @project.finish_task(task_two.id)
    @project.finish_task(task_four.id)

    task_four.stub(:create_time).and_return(Time.new(2012))
    task_two.stub(:create_time).and_return(Time.new(2013))
    task_one.stub(:create_time).and_return(Time.new(2014))

    expect(@project.get_complete_tasks).to eq([task_four, task_two, task_one])
  end

  it "lists incomplete tasks, sorted by priority, then by age" do
    TM::Task.stub(:all_tasks).and_return([])

    task_one = @project.add_task("do stuff", 3)
    task_two = @project.add_task("do more stuff", 4)
    task_three = @project.add_task("do other stuff", 3)
    task_four = @project.add_task("nap", 2)
    task_five = @project.add_task("golf", 1)

    task_one.stub(:create_time).and_return(Time.new(2013))
    task_three.stub(:create_time).and_return(Time.new(2012))

    @project.finish_task(task_two.id)

    expect(@project.get_incomplete_tasks).to eq([task_five, task_four, task_three, task_one])  
  end



end

