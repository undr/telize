# Telize

A ruby client for Telize geoip service.

http://www.telize.com/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telize'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install telize
```

## Usage

Configure it if needed

```ruby
Telize.configure do |config|
  config.host = 'localhost' # Default is www.telize.com
  config.port = 8080        # Default is nil
  config.timeout = nil      # Default is 10
end
```

and ask the service

```ruby
Telize.ip
# => "212.47.239.17"

Telize.geoip

# => {"dma_code"=>"0",
#  "ip"=>"212.47.239.17",
#  "asn"=>"AS12876",
#  "latitude"=>48.86,
#  "country_code"=>"FR",
#  "offset"=>"2",
#  "country"=>"France",
#  "isp"=>"ONLINE S.A.S.",
#  "timezone"=>"Europe/Paris",
#  "area_code"=>"0",
#  "continent_code"=>"EU",
#  "longitude"=>2.35,
#  "country_code3"=>"FRA"}

Telize.geoip('74.125.225.224')

# => {"dma_code"=>"0",
#  "ip"=>"74.125.225.224",
#  "asn"=>"AS15169",
#  "city"=>"Mountain View",
#  "latitude"=>37.4192,
#  "country_code"=>"US",
#  "offset"=>"-7",
#  "country"=>"United States",
#  "region_code"=>"CA",
#  "isp"=>"Google Inc.",
#  "timezone"=>"America/Los_Angeles",
#  "area_code"=>"0",
#  "continent_code"=>"NA",
#  "longitude"=>-122.0574,
#  "region"=>"California",
#  "postal_code"=>"94043",
#  "country_code3"=>"USA"}

Telize.geoip('74.125.')
# => {}
```

## Contributing

1. Fork it ( https://github.com/undr/telize/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
