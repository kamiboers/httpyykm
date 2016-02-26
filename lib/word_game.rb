require 'pry'

class WordSearch
  attr_reader :response, :word_fragment

  def initialize(path)
    @words = []
    @word_fragment = path.split("=")[1]
  end

  def run_word_search
    add_dictionary
    instances = count_fragment_instances_in_dictionary
    instances > 0 ? affirmative_response : negative_response
  end

  def add_dictionary
    File.open('/usr/share/dict/words').each do |line|
      @words << line.chomp
    end
  end

    def count_fragment_instances_in_dictionary
      instances = @words.count do |word|
        word.include?(@word_fragment)
      end
      instances
    end

  def affirmative_response
    @response = "#{@word_fragment} is a known word or word fragment"
  end

  def negative_response
    @response = "#{@word_fragment} is not a known word or word fragment"
  end


end
