require 'pg'
require 'random_data'

def gen_name
  Random.first_name + " " + Random.last_name
end

c = PGconn.new(:host => "localhost", :dbname => "employees_example")

employee_ids = [nil, nil, nil, nil]
100.times do
  c.exec_params("INSERT into employees (name, manager_id) VALUES ($1, $2)", [gen_name, employee_ids.sample])
  new_id = c.exec_params("SELECT currval('employees_id_seq');").first["currval"]
  employee_ids << new_id
end

c.close
