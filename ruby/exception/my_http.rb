module MyHttp
  class Error < StandardError; end

  class HttpError < Error
    def initialize(message = 'HTTP request failed', status:, body:, headers:)
      @status = status
      @body   = body
      @headers = headers

      super(message)
    end

    attr_reader :status, :body, :headers
  end

  class ProtocolError < Error; end

  class NetworkError < Error; end
end
