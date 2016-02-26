class Request
  attr_reader :lines, :request_hash, :remaining_lines, :verb, :path, :protocol, :host, :port

  def initialize(request)
    @lines = request
  end

  def begin_processing
    @request_hash = request_to_hash(@lines)
    interpret_request(request_hash)
  end

  def request_to_hash(request)
    headers = ["Verb", "Path", "Protocol"]
    request_hash = Hash[headers.zip(request.first.split.map { |a| a })]
    request_hash["Host"] = request[1].split[1].split(":")[0]
    request_hash["Port"] = request[1].split[1].split(":")[1]
    @remaining_lines = (request[2..-1].map { |line| line.split(": ") }.to_h)
    request_hash
  end

  def interpret_request(request_hash)
    @verb = request_hash["Verb"]
    @path = request_hash["Path"]
    @protocol = request_hash["Protocol"]
    @host = request_hash["Host"]
    @port = request_hash["Port"]
  end
end
