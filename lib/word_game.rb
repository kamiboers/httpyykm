require 'pry'

class WordGame
  attr_reader :response

  def initialize(path)
    @words = []
    @word_fragment = path.slice(18..-1)
    File.open('/usr/share/dict/words').each do |line|
      @words << line.chomp
    end
    count_fragment_instances_in_dictionary
  end

  def count_fragment_instances_in_dictionary
  instances = @words.count do |word|
      word.include?(@word_fragment)
  end
  if instances > 0
    affirmative_response
  else
    negative_response
  end
  end

  def affirmative_response
    @response = "#{@word_fragment} is a known word (fragment)"
  end

  def negative_response
    @response = "#{@word_fragment} is not a known word (fragment)"
  end


end
