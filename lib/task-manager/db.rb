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
  end

  #def self.get_project(data)
  #end

  # def self.update_project(id, data)
  # end

  def self.delete_project(id)
    command = <<-sQL
      DELETE FROM projects WHERE id='#{id}'
    sQL
    @@db.exec(command)
  end

          # TASKS


  def self.create_task(project_id, priority, description, time)
    command = <<-sQL
      INSERT INTO tasks(project_id, priority, description, creation_time)
      VALUES ('#{project_id}', '#{priority}', '#{description}', '#{time}')
    sQL
    @@db.exec(command)
  end

  # def self.get_task(id)
  # end

  # def self.update_task(id, data)
  # end

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







