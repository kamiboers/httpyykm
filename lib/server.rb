require 'socket'
require 'pry'
require_relative 'request'
require_relative 'response'

class Server
  def initialize(root=9292, count=0)
    server = TCPServer.new(root)
    @count = count
    @break = nil
    puts "Ready for a request"
    open_server(server)
  end


  def open_server(server)
    until @break == true do
      @client = server.accept
      begin_request_processing
    end
    close_client
  end

  def begin_request_processing
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request = Request.new(request_lines)
    display_request(request)
    request.interpret_request
    begin_response(request)
  end

  def display_request(request)
    puts "Got this request:"
    puts request.request_lines.inspect
    @count += 1
  end

  def begin_response(request)
    puts "Sending response."
    response = Response.new(request, @count, @client)
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
  server = Server.new
end
