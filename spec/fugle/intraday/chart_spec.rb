# frozen_string_literal: true

RSpec.describe Fugle::Intraday::Chart do
  subject(:chart) { described_class.new(data) }

  let(:data) do
    {
      'o' => [1, 2, 1],
      'h' => [2, 3, 2],
      'l' => [1, 1, 1],
      'c' => [1, 2, 2],
      'v' => [100, 50, 90],
      't' => %w[1641459374000 1641459374000 1641459374000]
    }
  end

  describe '#to_json' do
    subject { chart.to_json }

    it { is_expected.not_to be_empty }
    it { is_expected.to include('"open":1') }
    it { is_expected.to include('"high":2') }
    it { is_expected.to include('"low":1') }
    it { is_expected.to include('"close":1') }
    it { is_expected.to include('"volume":1') }
    it { is_expected.to include('"time":') }
  end
end
