require 'rails_helper'

describe CostService do
  describe '.new' do
    subject { described_class.new(25) }

    it 'Sets kilometers' do
      expect(subject.kilometers).to eq(25)
    end
  end

  describe '.calculate' do
    subject { described_class.new(25).calculate(weight) }

    context 'when weight is 5' do
      let(:weight) { 5 }

      it 'Calculates shipping cost' do
        is_expected.to eq(18.75)
      end
    end

    context 'when weight is 10' do
      let(:weight) { 10 }

       it 'Calculates shipping cost' do
        is_expected.to eq(37.5)
      end
    end
  end

  describe '::TAX' do
    subject { described_class::TAX }

    it 'returns TAX' do
      is_expected.to eq(0.15)
    end
  end
end

