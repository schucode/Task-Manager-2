
class TM::Task 
	attr_reader :description, :priority
	attr_accessor :id, :pro_id, :done_status, :create_time

	@@counter = 0
	@@all_tasks = []

	def initialize(description, priority)
		@description = description
		@id = @@counter
		@pro_id = nil
		@priority = priority
		@done_status = false
		@create_time = nil
		@@all_tasks << self
		@@counter += 1
	end

	def self.all_tasks
		@@all_tasks
	end

	def self.all_tasks=(reset)
		@@all_tasks = reset
	end

	def self.counter
		@@counter
	end

	def self.counter=(reset)
		@@counter = reset
	end

end
