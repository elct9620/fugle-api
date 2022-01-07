# frozen_string_literal: true

RSpec.describe Fugle::Intraday::Chart do
  subject(:chart) { described_class.new(data) }

  let(:data) { JSON.parse(File.read('spec/fixtures/intraday/chart.json')).dig('data', 'chart') }

  describe '#to_json' do
    subject { chart.to_json }

    it { is_expected.not_to be_empty }
    it { is_expected.to include('"open":148.3') }
    it { is_expected.to include('"high":148.75') }
    it { is_expected.to include('"low":148.3') }
    it { is_expected.to include('"close":148.65') }
    it { is_expected.to include('"volume":168') }
    it { is_expected.to include('"time":') }
  end
end
