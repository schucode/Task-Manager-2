require 'pg'

class TM::DB #manages database

  @@db = PG.connect(host: 'localhost', dbname: 'task-database')

  def self.db
    @@db
  end

        # PROJECTS

  def self.create_project(name)
    command = <<-sQL
      INSERT INTO projects(name) VALUES ('#{name}')
    sQL
    @@db.exec(command)
    return "success"
  end

  def self.delete_project(id)
    command = <<-sQL
      DELETE FROM projects WHERE id='#{id}'
    sQL
    @@db.exec(command)
  end

  def self.show_project(id)
    command = <<-sQL
      SELECT * FROM tasks WHERE project_id='#{id}' AND done_status='false';
    sQL
    return @@db.exec(command)
  end

  # def self.update_project(id, data)
  # end

  

          # TASKS


  def self.add_task(project_id, priority, description, time)
    command = <<-sQL
      INSERT INTO tasks(project_id, priority, description, creation_time)
      VALUES ('#{project_id}', '#{priority}', '#{description}', '#{time}')
    sQL
    @@db.exec(command)
  end

  def self.get_task(id)
    command = <<-sQL 
      SELECT * FROM tasks WHERE id='#{id}'
    sQL
    return @@db.exec(command)
  end

  def self.update_task(id)
    command = <<-sQL
      UPDATE tasks SET done_status = true WHERE id='#{id}'
    sQL
  end

  # def self.delete_task(id)
  # end

end


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
# PRIMARY KEY (id)


# SELECT * FROM users WHERE id=2;
# SELECT * FROM users WHERE email='sally@computeruser.com';
# SELECT * FROM users LIMIT 2;
# SELECT * FROM users ORDER BY name;




