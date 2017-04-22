require 'rails_helper'

describe Path do
  describe '.new' do
    context 'when has only distance' do
      subject { described_class.new(distance) }

      let(:distance) { Distance.new }

      it 'adds distance' do
        expect(subject.distances).to eq([distance])
      end
    end

    context 'when has distance and path' do
      subject { described_class.new(distance, path) }

      let(:path) { Path.new(distance_old) }
      let(:distance_old) { Distance.new }
      let(:distance) { Distance.new }

      it 'adds two distances' do
        expect(subject.distances).to eq([distance_old, distance])
      end
    end

    it 'has distances as Array' do
      expect(subject.distances).to be_a(Array)
    end
  end

  describe '.distance' do
    subject { instance.distance }

    let(:instance) { Path.new }

    context 'when has one distance' do
      before do
        instance.distances << double(kilometers: kilometers)
      end

      context 'with 10 kilometers' do
        let(:kilometers) { 10 }

        it 'returns kilometers' do
          is_expected.to eq(10)
        end
      end

      context 'with 20 kilometers' do
        let(:kilometers) { 20 }

        it 'returns kilometers' do
          is_expected.to eq(20)
        end
      end
    end

    context 'when has two distances' do
      before do
        instance.distances << double(kilometers: 10)
        instance.distances << double(kilometers: 15)
      end

      it 'sums the distances' do
        is_expected.to eq(25)
      end
    end
  end

  describe '.end' do
    subject { instance.end }
    let(:instance) { described_class.new }

    context 'when has only one distance' do
      before do
        instance.distances << double(destination: 'B')
      end

      it 'returns "B"' do
        is_expected.to eq('B')
      end
    end

    context 'when has two distances' do
      before do
        instance.distances << double(destination: 'B')
        instance.distances << double(destination: 'C')
      end

      it 'returns the last' do
        is_expected.to eq('C')
      end
    end
  end
end
