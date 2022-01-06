# frozen_string_literal: true

RSpec.describe Fugle::Intraday::Meta do
  subject(:meta) { described_class.new(data) }

  let(:data) do
    JSON.parse(File.read('spec/fixtures/intraday/meta.json')).dig('data', 'meta')
  end

  describe '#to_h' do
    subject { meta.to_h }

    it { is_expected.to include(name: '元大台灣50') }
    it { is_expected.to include(can_day_buy_sell: true) }
    it { is_expected.to include(can_day_sell_buy: true) }
    it { is_expected.to include(can_short_lend: true) }
    it { is_expected.to include(can_short_margin: true) }
    it { is_expected.to include(industry: nil) }
    it { is_expected.to include(is_index: false) }
    it { is_expected.to include(is_suspended: false) }
    it { is_expected.to include(is_terminated: false) }
    it { is_expected.to include(is_warrant: false) }
    it { is_expected.to include(type: 'ETF') }
    it { is_expected.to include(:price) }
  end
end
