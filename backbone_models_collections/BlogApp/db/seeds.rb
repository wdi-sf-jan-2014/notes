# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.create({title: "Traveling Pants", text: "A story about sisterhood", author: "unkonwn"})
Post.create({title: "Backbone models", text: "Read the docs for more info", author: "Tim"})
Post.create({title: "College Ultimate Rankings", text: "I had no idea UNC was so good at ultimate.  Also Georgia Tech is ranked above Georgia.  Go Jackets!", author: "Me"})