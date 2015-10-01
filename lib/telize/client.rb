require 'net/http'

module Telize
  class Client
    attr_reader :config

    def initialize(config = Config.new)
      @config = config
    end

    def ip
      perform('/jsonip')['ip']
    end

    def geoip(ip_address = nil)
      perform(['', 'geoip', ip_address].compact.join(?/))
    end

    private

    def perform(url)
      response = do_request_to(url)

      case response
      when Net::HTTPSuccess
        decode_body(response.body)
      else
        {}
      end
    rescue Net::OpenTimeout, Net::ReadTimeout, Net::HTTPBadResponse => e
      {}
    end

    def do_request_to(url)
      Net::HTTP.start(
        config.host,
        config.port,
        open_timeout: config.timeout, read_timeout: config.timeout
      ) { |http| http.request_get(url) }
    end

    def decode_body(body)
      MultiJson.load(body)
    rescue MultiJson::ParseError => _
      {}
    end
  end
end
