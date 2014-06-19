
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

  def 

  def self.delete_some_project(id)
    TM::DB.delete_project(id)
  end 

  def self.create_some_task(project_id, priority, description) 
    t = Time.now
    TM::DB.create_task(project_id, priority, description, t.to_s)
  end

  def self.finished_task(task_id) 
  
  end

  def self.help
    puts ""
    puts "  help - Show these commands again"
    puts "  create P - Create a project named P"
    puts "  delete P - Delete a project named P"
    puts "  show P - Show tasks that have not been completed in project P"
    puts "  history P - Show task that have been completed in Project P"
    puts "  add P PRI D - add a task to project P with priority PRI and description D"
    puts "  finish T - Make task T as completed"
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
      self.show_some_proect(input[1])

    when "show" 
      puts "Here are the remaining tasks for project with id #{input[1]}"
      project_id = input[1].to_i
      self.show_incomplete(project_id)
    when "history"
      puts "Here are the completed tasks for the project with id #{input[1]}"
      project_id = input[1].to_i
      self.show_completed(prject_id)
    when "add" 
      project = input[1].to_i
      priority = input[2].to_i
      description = input[3]
      self.create_some_task(project, priority, description)
    when "finish"
      task = input[1].to_i
      finished_task(task)
    else
      puts "not a command"
    end
  end 
  puts "Have a great day!"

end
