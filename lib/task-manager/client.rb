
class TM::Client

  def self.clearOut
    TM::Project.all_projects = []
    TM::Project.counter = 0
    TM::Task.all_tasks = []
    TM::Task.counter = 0
  end


  def self.list_projects
    return TM::DB.show_project_list
  end

  def self.create_some_project(name)
    TM::DB.create_project(name)
  end

  def self.show_some_project(id)
    return TM::DB.show_project(id)
  end

  def self.history_of_project(id)
    return TM::DB.history_project(id)
  end

  def self.employees_on_project(id)
    return TM::DB.project_employees(id)
  end

  def self.add_employee_to_project(project_id, employee_id)
    TM::DB.project_add_employee(project_id, employee_id)
  end

  def self.create_some_task(project_id, priority, description) 
    t = Time.now
    TM::DB.add_task(project_id, priority, description, t.to_s)
  end

  def self.assign_some_task(task_id, employee_id)
    TM::DB.assign_task(task_id, employee_id)
  end





  def self.get_some_task(id)
    return TM::DB.get_task(id)
  end

  def self.update_some_task(id)
    TM::DB.update_task(id)
  end

  def self.delete_some_task(id)
    TM::DB.delete_task(id)
  end

  def self.help
    puts ""
    puts "  help - Show these commands again"
    puts "  project_list - List all projects"
    puts "  project_create NAME - Create a project "
    puts "  project_delete ID - Delete a project with ID"
    puts "  project_show ID - Show remaining tasks"
    puts "  project_history ID - Show completed tasks"
    puts "  project_employees ID - Show employees involved in project"
    puts "  project_recruit PID EID - Add employee EID to project PID"
    puts "  task_create PID PRIORITY DESC - add a task to project PID, give it a PRIORITY, and a DESCription"
    puts "  task_assign TID EID - Assign task TID to employee EID"


    puts "  get ID - Get and show data for task with ID"
    puts "  update ID - Update task with ID to completed status"
    puts "  deltask ID - Delete task with ID"
    puts ""
  end

  self.clearOut

  puts "Welcome to the Task Manager!"
  puts "What would you like to do today?"

  self.help

  user_input = nil

  while user_input != "exit" do
    print "> "
    user_input = gets.chomp()
    input = user_input.split

    case input[0]

    when "help"
      self.help
    when "project_list"
      result = self.list_projects
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end
    when "project_create" #Name
      self.create_some_project(input[1])
    when "project_show" #ID
      result = self.show_some_project(input[1])
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}, #{value}"
        end
        puts ""
      end
    when "project_history" #ID
      result = self.history_of_project(input[1])
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}, #{value}"
        end
        puts ""
      end
    when "project_employees" #ID
      result = self.employees_on_project(input[1])
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}, #{value}"
        end
        puts ""
      end
    when "project_recruit" # PID EID
      project_id = input[1].to_i
      employee_id = input[2].to_i
      self.add_employee_to_project(project_id, employee_id)
    when "task_create" # PID PRIORITY DESCRIPTION
      project = input[1].to_i
      priority = input[2].to_i
      description = input[3]
      self.create_some_task(project, priority, description)
    when ""
      task_id = input[1].to_i
      employee_id = input[2].to_i
      self.assign_some_task(task_id, employee_id)
    # when "get"
    #   result = self.get_some_task(input[1])
    #   result[0].each do |key, value| 
    #     puts "#{key}, #{value}"
    #   end
    #   puts ""
    # when "update"
    #   self.update_some_task(input[1])
    # when "deltask"
    #   self.delete_some_task(input[1])
    else
      puts "not a command"
    end
  end 
  puts "Have a great day!"

end
