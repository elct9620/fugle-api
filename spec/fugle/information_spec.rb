# frozen_string_literal: true

RSpec.describe Fugle::Information do
  subject(:info) { described_class.new(data) }

  let(:data) { JSON.parse(File.read('spec/fixtures/intraday/meta.json')).dig('data', 'info') }

  describe '#to_h' do
    subject { info.to_h }

    it { is_expected.to include(country_code: 'TW') }
    it { is_expected.to include(exchange: 'TWSE') }
    it { is_expected.to include(market: 'TSE') }
    it { is_expected.to include(symbol: '0050') }
    it { is_expected.to include(timezone: 'Asia/Taipei') }
    it { is_expected.to include(type: 'EQUITY') }
    it { is_expected.to include(:date) }
    it { is_expected.to include(:updated_at) }
  end
end
