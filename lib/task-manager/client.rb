
class TM::Client

  def self.clearOut
    TM::Project.all_projects = []
    TM::Project.counter = 0
    TM::Task.all_tasks = []
    TM::Task.counter = 0
  end


  def self.create_some_project(name)
    TM::DB.create_project(name)
  end

  def self.delete_some_project(id)
    TM::DB.delete_project(id)
  end 

  def self.show_some_project(id)
    return TM::DB.show_project(id)
  end

  def self.add_some_task(project_id, priority, description) 
    t = Time.now
    TM::DB.add_task(project_id, priority, description, t.to_s)
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
    puts "  create P - Create a project named P"
    puts "  delete ID - Delete a project with ID"
    puts "  show ID - Show tasks that have not been completed in project with ID"
    puts "  add P PRI D - add a task to project P with priority PRI and description D"
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
    when "create"
      self.create_some_project(input[1])
    when "delete"
      self.delete_some_project(input[1])
    when "show"
      result = self.show_some_project(input[1])
      result.each do |i| # i is a hash
        i.each do |key, value| 
        puts "#{key}, #{value}"
        end
        puts ""
      end
    when "add" 
      project = input[1].to_i
      priority = input[2].to_i
      description = input[3]
      self.create_some_task(project, priority, description)
    when "get"
      result = self.get_some_task(input[1])
      result[0].each do |key, value| 
        puts "#{key}, #{value}"
      end
      puts ""
    when "update"
      self.update_some_task(input[1])
    when "deltask"
      self.delete_some_task(input[1])
    else
      puts "not a command"
    end
  end 
  puts "Have a great day!"

end
