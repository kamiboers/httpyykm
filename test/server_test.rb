require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/server'

class ServerTest < Minitest::Test

def test_server_transcribes_request_into_array
  test_server = Server.new
  request = ""
  test_server.transcribe_request()
  
end

def test_it_returns_to_client_string_hello_world
  tcp_server = Server.new
  assert_equal tcp_server
end

end
