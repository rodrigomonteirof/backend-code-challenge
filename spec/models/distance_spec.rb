require 'rails_helper'

describe Distance do
  describe '.new' do
    subject { described_class.new({origin: 'A', destination: 'B', kilometers: 10}) }

    it 'sets origin' do
      expect(subject.origin).to eq('A')
    end

    it 'sets destination' do
       expect(subject.destination).to eq('B')
    end

    it 'sets kilometers' do
      expect(subject.kilometers).to eq(10)
    end
  end

  describe '.valid?' do
    subject { instance.valid? }

    let(:instance) { described_class.new(attrs) }

    context 'when input is valid' do
      let(:attrs) { { origin: 'A', destination: 'B', kilometers: 1 } }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'when kilometers is zero' do
      let(:attrs) { { origin: 'A', destination: 'B', kilometers: 0 } }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when kilometers is less then zero' do
      let(:attrs) { { origin: 'A', destination: 'B', kilometers: -1 } }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when kilometers is 100k' do
      let(:attrs) { { origin: 'A', destination: 'B', kilometers: 100000 } }

      it 'returns false' do
        is_expected.to be_truthy
      end
    end

    context 'when kilometers is more then 100k' do
      let(:attrs) { { origin: 'A', destination: 'B', kilometers: 100001 } }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when origin is nil' do
      let(:attrs) { { destination: 'B', kilometers: 1 } }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'when destination is nil' do
      let(:attrs) { { origin: 'A', kilometers: 1 } }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end
  end
end
