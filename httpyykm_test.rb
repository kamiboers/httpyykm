require 'minitest/autorun'
require 'minitest/pride'
require_relative 'httpyykm'
require 'pry'

class HTTPTest < Minitest::Test

def test_the_server_receives_client_content
  assert_equal request_content.join("\n")
end

def test_the_server_receives_HTTP_requests
end

def test_the_server_responds_to_HTTP_requests
end

def test_the_server_output_displays_iterations
end

end
