# frozen_string_literal: true

RSpec.describe Fugle::Config do
  subject(:config) { described_class.new }

  describe '#api_token' do
    subject { config.api_token }

    it { is_expected.to be_nil }

    context 'when FUGLE_API_TOKEN is configured' do
      before do
        allow(ENV).to receive(:[]).with('FUGLE_API_TOKEN').and_return('DUMMY_TOKEN')
      end

      it { is_expected.to eq('DUMMY_TOKEN') }
    end

    context 'when api_token is given' do
      let(:config) { described_class.new(api_token: 'DUMMY_TOKEN') }

      it { is_expected.to eq('DUMMY_TOKEN') }
    end
  end
end
