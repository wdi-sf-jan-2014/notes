# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mentors = []
mentors << Mentor.create(name: 'Mary')
mentors << Mentor.create(name: 'Max')
mentors << Mentor.create(name: 'Rodger')
mentors << Mentor.create(name: 'Janet')
mentors << Mentor.create(name: 'Jacob')

students = []
students << Student.create(name: 'John', sid: 'RD1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Mark', sid: 'PQ1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Larry', sid: 'LM1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Laura', sid: 'Z3434', mentor_id: mentors.sample.id)
students << Student.create(name: 'Leslie', sid: 'RD1999', mentor_id: mentors.sample.id)
students << Student.create(name: 'Apple', sid: 'AB1551', mentor_id: mentors.sample.id)
students << Student.create(name: 'Fiona', sid: 'MM1299', mentor_id: mentors.sample.id)
students << Student.create(name: 'North', sid: '4ZZZZ9', mentor_id: mentors.sample.id)

i = 0
while i < students.length
  if (i % 2 == 0)
    Account.create(balance: 0.0, student_id: students[i].id)
  else
    Account.create(balance: 3000.0, student_id: students[i].id)
  end 
  i += 1
end


courses = []
courses << Course.create(name: 'CS101', description: 'Intro to CS')
courses << Course.create(name: 'CS201', description: 'Algorithms and Data Structures')
courses << Course.create(name: 'CS250', description: 'Databases')
courses << Course.create(name: 'CS285', description: 'Networking')
courses << Course.create(name: 'CS210', description: 'Human Computer Interaction')

courses[0].students << students[-1]
courses[0].students << students[-2]
courses[0].students << students[-3]
courses[0].students << students[-4]

courses[1].students << students[0]
courses[1].students << students[1]
courses[1].students << students[2]
courses[1].students << students[3]

courses[2].students << students[3]
courses[2].students << students[4]

courses[3].students << students[4]
courses[3].students << students[5]
courses[3].students << students[6]
courses[3].students << students[2]

courses[4].students << students[-1]
courses[4].students << students[-2]
