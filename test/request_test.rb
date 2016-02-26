require 'httparty'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/request'
require 'pry'

class RequestTest < Minitest::Test

def test_interprets_request_for_diagnostics
  request_lines = ["GET /hello HTTP/1.1", "Host: localhost:9292","Connection: keep-alive", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36", "DNT: 1", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]

  testreq = Request.new(request_lines)
  testreq_hash = testreq.request_to_hash(request_lines)
  testreq.interpret_request(testreq_hash)

  assert_equal "GET", testreq.verb
  assert_equal "/hello", testreq.path
  assert_equal "HTTP/1.1", testreq.protocol
  assert_equal "localhost", testreq.host
  assert_equal "9292", testreq.port
end

end
