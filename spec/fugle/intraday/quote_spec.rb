# frozen_string_literal: true

RSpec.describe Fugle::Intraday::Quote do
  subject(:quote) { described_class.new(data) }

  let(:data) do
    JSON.parse(File.read('spec/fixtures/intraday/quote.json')).dig('data', 'quote')
  end

  describe '#to_h' do
    subject { quote.to_h }

    it { is_expected.to include(:trial) }
    it { is_expected.to include(:order) }
    it { is_expected.to include(:price) }
    it { is_expected.to include(:trade) }
    it { is_expected.to include(:total) }
  end
end
