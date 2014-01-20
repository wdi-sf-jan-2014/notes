require 'pry'
require 'pg'
require 'random_data'
require 'openlibrary'
require 'json'

@l = Openlibrary.new()

@c = PGconn.new(:host => "localhost", :dbname => "all_libraries")

def gen_address
  Random.address_line_1 + "\n" + Random.address_line_2
end

def gen_lib_name
  r = rand
  if rand < 0.4
    r = " "
  elsif rand < 0.6
    r = " Downtown "
  elsif rand < 0.9
    r = " Main "
  else
    r = " Children's "
  end
  Random.city + r + "Library"
end
def gen_books
  searches = ["Rings", "Frankenstein", "Monsters",
              "Glory", "America", "Lasers", "Math", "Steel",
              "Wine", "Beer", "Water", "Chemistry"]
  pages = 5
  #books = []
  #searches.each do |s|
  #  1.upto(pages).each do |n|
  #    res = @l.search(:q => s, :page => n, :sort => "new")
  #    books += res
  #  end
  #end
  #File.open("books.json",'w') {|f| f.write(books.to_json)}

  books = JSON.load(File.read("books.json"))
  isbns = []
  books.map do |b|
    begin
      isbn = b["isbn"].nil? ? b["key"] : b["isbn"][0]
      unless isbns.include?(isbn)
        isbns << isbn
        @c.exec_params("INSERT INTO books (isbn, title, author) VALUES ($1, $2, $3)",
                       [isbn, b["title"], b["author_name"][0]])
        @c.exec_params("SELECT currval('books_id_seq');").first["currval"]
      end
    rescue PG::UniqueViolation
      # If there's a problem putting a book in the db just forget about it.
    rescue
    end
  end
end

def gen_libraries
  n_libraries = 8
  lib_ids = []
  n_libraries.times do

    @c.exec_params("INSERT INTO libraries (name, address) VALUES ($1, $2)", [gen_lib_name, gen_address])
    lib_ids << @c.exec_params("SELECT currval('libraries_id_seq');").first["currval"]
  end
  lib_ids
end


def gen_copies(book_ids, lib_ids)
  book_ids.each do |b|
    lib_ids.each do |l|
      r = rand
      if rand < 0.3

      elsif rand < 0.8
        @c.exec_params("INSERT INTO book_copies (book_id, library_id) VALUES ($1, $2)", [b, l])
      else
        rand(5).times do
          @c.exec_params("INSERT INTO book_copies (book_id, library_id) VALUES ($1, $2)", [b, l])
        end
      end
    end
  end
end

gen_copies(gen_books, gen_libraries)

@c.close
