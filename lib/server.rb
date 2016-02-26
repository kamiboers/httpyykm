require 'socket'
require 'pry'
require_relative 'request'
require_relative 'response'

class Server
  def initialize(root=9292, count=0)
    @request_count = count
    @root = root
  end

  def open_server
    server = TCPServer.new(@root)
    puts "Ready for a request"
    loop do
      @client = server.accept
      begin_request_processing
      close_client
    end
  end

  def begin_request_processing
    request = Request.new(transcribe_request)
    request.begin_processing
    display_request(request)
    begin_response(request)
  end

  def transcribe_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def display_request(request)
    puts "Got this request:"
    puts request.lines.inspect
    @request_count += 1
  end

  def begin_response(request)
    puts "Sending response."
    response = Response.new(request, @request_count)
    response.create_response(request)

    send_response_to_client(response)
    display_response(response)
  end

  def send_response_to_client(response)
    @client.puts response.headers
    @client.puts response.output
  end

  def display_response(response)
    puts ["Wrote this response:", response.headers, response.output].join("\n")
  end

  def close_client
    @client.close
    puts "\nResponse complete, exiting."
  end

end

if __FILE__ == $0
  test_server = Server.new
  test_server.open_server
end
