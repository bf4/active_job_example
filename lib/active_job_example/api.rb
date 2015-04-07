require "json"
require "faraday"
module ActiveJobExample
  module Api
    Error = Class.new(Faraday::Error) do
      attr_reader :original
      def initialize(msg, original = $!)
        @original = original
      end
    end
    BasicResponse = Struct.new(:status, :body)

    def self.url
      "http://ifconfig.me/host"
    end

    def self.body
      []
    end

    def self.default_headers
      {}
    end

    module_function

    def get(url, body, headers)
      get!(url, body, headers) do |e|
        BasicResponse.new(
          500,
          [e.class,
           e.message,
           "[#{url},#{body},#{headers}]",
           e.backtrace.join("\t\n")
          ].join("\t")
        )
      end
    end

    def get!(url, body, headers)
      Faraday.get(url, body, headers)
    rescue Faraday::ConnectionFailed => e
      if block_given? 
        yield e
      else
        raise Error, e.message, e.backtrace
      end
    end

    def get_ip
      get Api.url, Api.body, Api.default_headers
    end

    def get_ip!
      get! Api.url, Api.body, Api.default_headers
    end
  end
end
