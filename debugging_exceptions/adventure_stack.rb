# Classes and Objects
## Code Along



story_hash = {
  "question" => "Welcome to the haunted hotel. What room would you like to go into?",
  "room 1" => "you're dead",
  "room 2" => { "question" => "You picked a good room. What would like to do?",
                "sleep" => "You're rested for the morning",
                "stay up all night" => "You might have anxiety issues"
}
}


class Adventure

  def initialize(story_hash)
    @story_hash = story_hash
  end


  def prompt(question, options)
    put "#{question}"
    put "#{options}"
    response = gets.chomp!
  end

  def prompt_n_chomp(question, options)
    res = prompt(question, options)
    until options.include?(res)
      puts "Sorry that was not a valid response"
      res = prompt(question,options)
    end
    res
  end

  def get_options(story_hash)
    options = story_hash.keys.select { |x| x != "question"}
  end

  def start
    story_hash = @story_hash
    question = @story_hash['question']
    options = get_options(story_hash)
    until options.nil?
      res = prompt_n_chomp(question, options)
      if story_hash[res].is_a?(Hash)
        story_hash = story_hash[res]
        question = story_hash['question']
        options = get_options(story_hash)
      else
        puts story_hash[res]
        options = nil
      end
    end

    "END OF ADVENTURE"
  end
end


adv = Adventure.new(story_hash)
adv.start()





