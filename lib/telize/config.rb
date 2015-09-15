module Telize
  class Config
    attr_accessor :host, :port, :timeout

    def initialize
      @host = 'www.telize.com'
      @port = nil
      @timeout = 10
    end
  end
end
