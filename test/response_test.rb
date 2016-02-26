require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/request'
require_relative '../lib/response'
require 'pry'

class ResponseTest < Minitest::Test

def test_it_returns_correct_path_response_for_hello
  request_lines = ["GET /hello HTTP/1.1", "Host: localhost:9292","Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1"]
  @request = Request.new(request_lines)
  @request.begin_processing
  test_response = Response.new(@request, 0)
  test_response.create_response(@request)
  assert_equal true, test_response.response.include?("Hello, World")
end

def test_it_returns_correct_path_response_for_datetime
  request_lines = ["GET /datetime HTTP/1.1", "Host: localhost:9292","Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1"]
  @request = Request.new(request_lines)
  @request.begin_processing
  test_response = Response.new(@request, 0)
  test_response.create_response(@request)
  assert_equal true, test_response.response.include?("#{Time.now.strftime('%A')}")
end

def test_it_returns_correct_path_response_for_shutdown
  request_lines = ["GET /shutdown HTTP/1.1", "Host: localhost:9292","Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1"]
  @request = Request.new(request_lines)
  @request.begin_processing
  test_response = Response.new(@request, 0)
  test_response.create_response(@request)
  assert_equal true, test_response.response.include?("Total Requests: ")
end

def test_it_returns_correct_path_response_for_word_search
  request_lines = ["GET /word_search?word=abcde HTTP/1.1", "Host: localhost:9292","Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1"]
  @request = Request.new(request_lines)
  @request.begin_processing
  test_response = Response.new(@request, 0)
  test_response.create_response(@request)
  assert_equal true, test_response.response.include?("known word or word fragment")
end

end
