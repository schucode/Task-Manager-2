
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

  def self.update_some_task(task_id)
    TM::DB.update_task(task_id)
  end

  def self.list_employees
    return TM::DB.show_employee_list
  end

  def self.create_some_employee(name)
    TM::DB.create_employee(name)
  end

  def self.show_some_employee(employee_id)
    return TM::DB.show_employee(employee_id)
  end

  def self.show_some_emp_details(employee_id)
    return TM::DB.show_emp_details(employee_id)
  end

  def self.history_of_emp(employee_id)
    return TM::DB.show_emp_history(employee_id)
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
    puts "  task_mark TID - Mark task as complete"
    puts "  emp_list - List all employees"
    puts "  emp_create NAME - Create an employee profile"
    puts "  emp_show EID - Show employee and their project" 
    puts "  emp_details EID - Show remaining tasks on project"
    puts "  emp_history EID - Show completed tasks for employee"
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
        puts "#{key}: #{value}"
        end
        puts ""
      end
    when "project_history" #ID
      result = self.history_of_project(input[1])
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end
    when "project_employees" #ID
      result = self.employees_on_project(input[1])
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
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
    when "task_assign"
      task_id = input[1].to_i
      employee_id = input[2].to_i
      self.assign_some_task(task_id, employee_id)
    when "task_mark"
      self.update_some_task(input[1])
    when "emp_list"
      result = self.list_employees
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end
    when "emp_create"
      self.create_some_employee(input[1])
    when "emp_show"
      employee_id = input[1].to_i
      result = self.show_some_employee(employee_id)
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end
    when "emp_details"
      employee_id = input[1].to_i
      result = self.show_some_emp_details(employee_id)
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end 
    when "emp_history"
      employee_id = input[1].to_i
      result = self.history_of_emp(employee_id)
      puts ""
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}: #{value}"
        end
        puts ""
      end 
    else
      puts "not a command"
    end
  end 
  puts "Have a great day!"

end
