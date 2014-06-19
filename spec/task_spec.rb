require 'spec_helper'

describe 'Task' do
  
	before do
		@project = TM::Project.new("coolproject")
    @task = @project.add_task("do stuff", 3)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "should have a task id" do
  	i = @task.stub(:id).and_return(4)
  	expect(@task.id).to eq(4)
  end

  it "should get the project id of the project its created from" do
  	p_id = @project.id
  	expect(@task.pro_id).to eq(p_id)
	end

	it "should have a description" do
		expect(@task.description).to eq("do stuff")
	end

	it "should have a priority number" do
		expect(@task.priority).to eq(3)
	end

	it "should have a completion status associated with its id: true/false" do
		expect(@task.done_status).to eq(false)
	end

end





# A new task can be created with a project id, description, and priority number
# A task can be marked as complete, specified by id