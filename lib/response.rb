require 'pry'
require_relative 'word_game'

class Response
  attr_reader :response, :headers, :output, :break

  def initialize(request, request_count)
    @count = request_count
    @request = request
    @response = ""
    @break = false
  end

  def create_response(request)
    add_response_path_components
    return_response_components
  end

  def return_response_components
    @output = "<html><head></head><body>#{@response}</body></html>"
    @headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{@output.length}\r\n\r\n"].join("\r\n")
    end

    def add_response_path_components
      if @request.path == "/"
        no_path_response
      elsif @request.path == "/hello"
        hello_response
      elsif @request.path == "/datetime"
        datetime_response
      elsif @request.path == "/shutdown"
        shutdown_response
      elsif @request.path.include?("/word_search")
        word_game_response
      end
    end

    def no_path_response
      @response +=
      "<pre>
      Verb: #{@request.verb}
      Path: #{@request.path}
      Protocol: #{@request.protocol}
      Host: #{@request.host}
      Port: #{@request.port}
      \t#{@request.remaining_lines.join("\n\t")}
      </pre>"
    end

    def hello_response
      @response += "<pre>
      Hello, World (#{@count})</pre>"
    end

    def datetime_response
      @response += "<pre>
      #{Time.now.strftime "%l:%M%p on %A, %B %e, %Y"}</pre>"
    end

    def shutdown_response
      @response += "<pre>
      Total Requests: #{@count}</pre>"
      @break = true
    end

    def word_game_response
      word_search = WordGame.new(@request.path)
      @response += word_search.response
    end

  end
