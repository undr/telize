require 'multi_json'
require 'telize/version'
require 'telize/config'
require 'telize/client'

module Telize
  extend self

  def config
    @config ||= Config.new
  end

  def configure
    yield config
    @client = nil
  end

  def ip
    client.ip
  end

  def geoip(ip_address = nil)
    client.geoip(ip_address)
  end

  private

  def client
    @client ||= Client.new(config)
  end
end
