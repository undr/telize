RSpec.describe Telize do
  describe '#configure' do
    let(:config) { Telize.config }

    specify do
      Telize.configure do |c|
        expect(c).to eq(config)
      end
    end
  end

  describe '#ip' do
    subject { Telize.ip }

    context 'when everything is ok' do
      let(:response) { '{"ip":"212.47.239.17"}' }

      before do
        stub_request(:get, 'http://www.telize.com/jsonip').
          to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })
      end

      it { is_expected.to eq('212.47.239.17') }
    end

    context 'when open timeout is occured' do
      before { stub_request(:get, 'http://www.telize.com/jsonip').to_raise(Net::OpenTimeout) }

      it { is_expected.to be_nil }
    end

    context 'when read timeout is occured' do
      before { stub_request(:get, 'http://www.telize.com/jsonip').to_raise(Net::ReadTimeout) }

      it { is_expected.to be_nil }
    end

    context 'when bad response is given' do
      before { stub_request(:get, 'http://www.telize.com/jsonip').to_raise(Net::HTTPBadResponse) }

      it { is_expected.to be_nil }
    end
  end

  describe '#geoip' do
    context 'when everything is ok' do
      let(:response) { '{"dma_code":"0","ip":"212.47.239.17","asn":"AS12876","latitude":48.86,"country_code":"FR","offset":"2","country":"France","isp":"ONLINE S.A.S.","timezone":"Europe\/Paris","area_code":"0","continent_code":"EU","longitude":2.35,"country_code3":"FRA"}' }
      let(:result) { {
        'dma_code'       => '0',
        'ip'             => '212.47.239.17',
        'asn'            => 'AS12876',
        'latitude'       => 48.86,
        'country_code'   => 'FR',
        'offset'         => '2',
        'country'        => 'France',
        'isp'            => 'ONLINE S.A.S.',
        'timezone'       => 'Europe/Paris',
        'area_code'      => '0',
        'continent_code' => 'EU',
        'longitude'      => 2.35,
        'country_code3'  => 'FRA'
      } }

      context 'and nothing was passed as argument' do
        subject { Telize.geoip }

        before do
          stub_request(:get, 'http://www.telize.com/geoip').
            to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })
        end

        it { is_expected.to eq(result) }
      end

      context 'and ip address was passed as argument' do
        subject { Telize.geoip('212.47.239.17') }

        before do
          stub_request(:get, 'http://www.telize.com/geoip/212.47.239.17').
            to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })
        end

        it { is_expected.to eq(result) }
      end
    end

    context 'when not valid ip address was passed as argument' do
      subject { Telize.geoip('212.47.') }

      let(:response) { '{"message":"Input string is not a valid IP address","code":401}' }

      before do
        stub_request(:get, 'http://www.telize.com/geoip/212.47.').
          to_return(status: 400, body: response, headers: { 'Content-Type' => 'application/json' })
      end

      it { is_expected.to eq({}) }
    end

    context 'when open timeout is occured' do
      subject { Telize.geoip }

      before { stub_request(:get, 'http://www.telize.com/geoip').to_raise(Net::OpenTimeout) }

      it { is_expected.to eq({}) }
    end

    context 'when read timeout is occured' do
      subject { Telize.geoip }

      before { stub_request(:get, 'http://www.telize.com/geoip').to_raise(Net::ReadTimeout) }

      it { is_expected.to eq({}) }
    end

    context 'when bad response is given' do
      subject { Telize.geoip }

      before { stub_request(:get, 'http://www.telize.com/geoip').to_raise(Net::HTTPBadResponse) }

      it { is_expected.to eq({}) }
    end
  end
end
