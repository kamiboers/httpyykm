require 'socket'
require 'pry'

class Server
  def initialize(root=9292, count=0)
    tcp_server = TCPServer.new(root)
    @count = count
    puts "Ready for a request"
    client = tcp_server.accept

    loop do
      transcribe_request(client)
    end
  end

  def transcribe_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    display_request(request_lines, client)
  end

  def display_request(request_lines, client)
    puts "Got this request:"
    puts request_lines.inspect
    compose_response(request_lines, client)
  end

  def compose_response(request_lines, client)
    puts "Sending response."
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      send_response(headers, output, client)
    end

    def send_response(headers, output, client)
      client.puts headers
      client.puts output
      @count += 1
      display_response(headers, output)
    end

    def display_response(headers, output)
      puts ["Wrote this response:", headers, output].join("\n")
    end

    def close_client(client)
      client.close
      puts "\nResponse complete, exiting."
    end

end

if __FILE__ == $0
server = Server.new
end
