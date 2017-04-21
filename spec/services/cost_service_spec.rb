require 'rails_helper'

describe CostService do
  describe '.new' do
    subject { described_class.new(5) }

    it 'Sets weight' do
      expect(subject.weight).to eq(5)
    end
  end

  describe '.valid?' do
    subject { described_class.new(weight).valid? }

    context 'when weight is valid' do
      let(:weight) { 5 }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'when weight is too low' do
      let(:weight) { 0 }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when weight is too high' do
      let(:weight) { 51 }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end
  end

  describe '.calculate' do
    subject { described_class.new(5).calculate(kilometers) }

    context 'when kilometers is 25' do
      let(:kilometers) { 25 }

      it 'Calculates shipping cost' do
        is_expected.to eq(18.75)
      end
    end

    context 'when kilometers is 50' do
      let(:kilometers) { 50 }

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

