require 'socket'

class Server

def initialize
  tcp_server = TCPServer.new(9292)
  report_that_server_is_open
  create_client(tcp_server)
end

def create_client(server)
  client = server.accept
  receive_request(client)
end

def report_that_server_is_open
  puts "Ready for a request."
end

def receive_request(client)
  request_content = []
  while request_line = client.gets && !request_line.empty?
    request_content << request_line.chomp
  end
end

# receive request by
# using inspect and splitting over "\n" ??

def return_result
end

def display_result
end

end

if __FILE__ == $0
server_iteration = Server.new


end
