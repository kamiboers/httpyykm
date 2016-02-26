require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/word_game'



class WordSearchTest < Minitest::Test

def test_initially_reduces_path_with_parameter_to_word
  test_search = WordSearch.new("/word_search?word=face")
  assert_equal "face", test_search.word_fragment
end

def test_word_search_returns_affirmative_for_known_words
test_search = WordSearch.new("/word_search?word=doggerel")
assert_equal "doggerel is a known word or word fragment", test_search.run_word_search
end

def test_word_search_returns_affirmative_for_known_word_fragments
test_search = WordSearch.new("/word_search?word=alphab")
test_search.run_word_search
assert_equal "alphab is a known word or word fragment", test_search.run_word_search
end

def test_returns_negative_for_unknown_word_fragments
  test_search = WordSearch.new("/word_search?word=catzzzzzzz")
  test_search.run_word_search
  assert_equal "catzzzzzzz is not a known word or word fragment", test_search.run_word_search
end

end
