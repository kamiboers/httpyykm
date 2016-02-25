require 'socket'
require 'pry'

class Server
  def initialize(root=9292, count=0)
    tcp_server = TCPServer.new(root)
    @count = count
    @break = nil
    puts "Ready for a request"


    until @break == true do
      @client = tcp_server.accept
      transcribe_request
    end

    close_client
  end

  def transcribe_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    display_request(request_lines)
  end

  def display_request(request_lines)
    puts "Got this request:"
    puts request_lines.inspect
    @count += 1
    interpret_request(request_lines)
    compose_response(request_lines)
  end

  def interpret_request(request_lines)
    @verb = request_lines.first.split.first
    @path = request_lines.first.split[1].strip
    @protocol = request_lines.first.split.last
    @host = request_lines[1].split(":")[1].strip
    @port = request_lines[1].split(":")[2].strip
    @remaining_lines = request_lines[2..-1].join("\n\t")
  end

  def compose_response(request_lines)
    puts "Sending response."
    @response = ""
    response_components_added

    output = "<html><head></head><body>#{@response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      send_response(headers, output)
      display_response(headers,output)
    end

    def response_components_added
      binding.pry
      if @path == "/"
        @response += "<pre>
          Verb: #{@verb}
          Path: #{@path}
          Protocol: #{@protocol}
          Host: #{@host}
          Port: #{@port}
          \t#{@remaining_lines}</pre>"
      elsif @path == "/hello"
        @response += "<pre>
        Hello, World (#{@count})</pre>"
      elsif @path == "/datetime"
        @response += "<pre>
        #{Time.now.strftime "%l:%M%p on %A, %B %e, %Y"}</pre>"
      elsif @path == "/shutdown"
        @client.puts "<pre>
        Total Requests: #{@count}</pre>"
        @break = true
      end
    end

    def send_response(headers, output)
      @client.puts headers
      @client.puts output
    end

    def display_response(headers, output)
      puts ["Wrote this response:", headers, output].join("\n")
    end

    def close_client
      @client.close
      puts "\nResponse complete, exiting."
    end

end

if __FILE__ == $0
server = Server.new
end
