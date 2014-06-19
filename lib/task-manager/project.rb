
class TM::Project #basically a collection of tasks
	attr_reader :name, :id

	@@all_projects = []
	@@counter = 0

	def initialize(name)
		@name = name
		@id = @@counter
		@@all_projects << self
		@@counter += 1
	end

	def add_task(description, priority)
		task = TM::Task.new(description, priority)
		task.pro_id = @id
		task.create_time = Time.now
		return task
	end

	def finish_task(task_id)
		task = TM::Task.all_tasks.find {|i| i.id == task_id}
		task.done_status = true
	end

	def get_complete_tasks
		array = TM::Task.all_tasks.select {|i| i.done_status == true}
		array = array.sort_by! {|i| i.create_time}
		return array
	end

	def get_incomplete_tasks
		array = TM::Task.all_tasks.select {|i| i.done_status == false}
		array = array.sort_by! {|i| i.priority}
		(array.length-2).times do |i|
			if array[i].priority == array[i+1].priority
				if array[i].create_time > array[i+1].create_time 
					array[i], array[i+1] = array[i+1], array[i]
				end
			end
		end
		return array
	end

	def self.all_projects
		@@all_projects
	end

	def self.all_projects=(reset)
		@@all_projects = reset
	end

	def self.counter
		@@counter
	end

	def self.counter=(reset)
		@@counter = reset
	end

end



