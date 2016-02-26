class Request
  attr_reader :request_lines, :verb, :path, :protocol, :host, :port, :remaining_lines
  def initialize(request_lines)
    @request_lines = request_lines
  end

  def interpret_request
    @verb = request_lines.first.split.first
    @path = request_lines.first.split[1].strip
    @protocol = request_lines.first.split.last
    @host = request_lines[1].split(":")[1].strip
    @port = request_lines[1].split(":")[2].strip
    @remaining_lines = request_lines[2..-1].join("\n\t")
  end

end
