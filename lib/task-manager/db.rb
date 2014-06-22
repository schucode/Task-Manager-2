require 'pg'

class TM::DB #manages database

  @@db = PG.connect(host: 'localhost', dbname: 'task-database')

  def self.db
    @@db
  end
        
        # PROJECTS

  def self.show_project_list
    command = <<-sQL
      SELECT * FROM projects
    sQL
    return @@db.exec(command)
  end

  def self.create_project(name)
    command = <<-sQL
      INSERT INTO projects(name) VALUES ('#{name}')
    sQL
    return @@db.exec(command)
  end

  def self.show_project(id)
    command = <<-sQL
      SELECT * FROM tasks WHERE project_id='#{id}' AND done_status='false'
    sQL
    return @@db.exec(command)
  end

  def self.history_project(id)
    command = <<-sQL
      SELECT * FROM tasks WHERE project_id='#{id}' AND done_status='true'
    sQL
    return @@db.exec(command)
  end  

  def self.project_employees(id)
    command = <<-sQL
      SELECT * FROM employees WHERE project_id='#{id}'
    sQL
    return @@db.exec(command)
  end

  def self.project_add_employee(project_id, employee_id)
    command = <<-sQL
      UPDATE employees SET project_id='#{project_id}' WHERE id='#{employee_id}'
    sQL
    return @@db.exec(command)
  end


          # TASKS


  def self.add_task(project_id, priority, description, time)
    command = <<-sQL
      INSERT INTO tasks(project_id, priority, description, creation_time)
      VALUES ('#{project_id}', '#{priority}', '#{description}', '#{time}')
    sQL
    @@db.exec(command)
  end

  def self.assign_task(task_id, employee_id)
    get_task_project_id = <<-sQL
      SELECT project_id FROM tasks WHERE id='#{task_id}';
    sQL

    task_project_id = get_task_project_id[0]['project_id']

    get_employee_project_id = <<-sQL
      SELECT project_id FROM employees WHERE id='#{employee_id}';
    sQL

    employee_project_id = get_employee_project_id[0]['project_id']

    if task_project_id == employee_project_id
      command = <<-sQL
        UPDATE tasks SET employee_id='#{employee_id}' WHERE id='#{task_id}'
      sQL
      @@db.exec(command)
    end
  end

  def self.update_task(task_id)
    command = <<-sQL
      UPDATE tasks SET done_status = true WHERE id='#{task_id}'
    sQL
    @@db.exec(command)
  end

          # EMPLOYEES

  def self.show_employee_list
    command = <<-sQL
      SELECT * FROM employees
    sQL
    return @@db.exec(command)
  end

  def self.create_employee(name)
    command = <<-sQL
      INSERT INTO employees(name)
      VALUES ('#{name}')
    sQL
    @@db.exec(command)
  end

  def self.show_employee(employee_id)
    command = <<-sQL 
      SELECT * FROM employees WHERE id='#{employee_id}'
    sQL
    return @@db.exec(command)
  end

  def self.show_emp_details(employee_id)
    command = <<-sQL 
      SELECT * FROM tasks WHERE employee_id='#{employee_id}'
      AND done_status='false'
    sQL
    return @@db.exec(command)
  end

  def self.show_emp_history(employee_id)
    command = <<-sQL 
      SELECT * FROM tasks WHERE employee_id='#{employee_id}'
      AND done_status='true'
    sQL
    return @@db.exec(command)
  end 
end

# X help - Show these commands again
# X project list - List all projects
# X project create NAME - Create a new project
# X project show PID - Show remaining tasks for project PID
# X project history PID - Show completed tasks for project PID
# X project employees PID - Show employees participating in this project
# X project recruit PID EID - Adds employee EID to participate in project PID

# X task create PID PRIORITY DESC - Add a new task to project PID
# X task assign TID EID - Assign task to employee
# X task mark TID - Mark task TID as complete

# X emp list - List all employees
# X emp create NAME - Create a new employee
# X emp show EID - Show employee EID and all participating projects
# X emp details EID - Show all remaining tasks assigned to employee EID,
#                     along with the project name next to each task
# X emp history EID - Show completed tasks for employee with id=EID



# Employees

# ID SERIAL
# name text
# project_id integer


# Projects Data Model

# name text
# id   SERIAL
# PRIMARY KEY (id)


# Tasks Data Model

# id SERIAL
# project_id integer
# priority integer
# description text
# done_status text DEFAULT false 
# creation_time text
# employee_id numeric (if they're working on the project with that task) ++ 
# PRIMARY KEY (id)




# An employee can be created with a name
# This must automatically generate and assign a unique id
# Multiple employees can participate in a single project
# Tasks can be assigned to an employee
# The employee must be participating in that project





