require 'rails_helper'

describe Path do
  describe '.new' do
    subject { described_class.new }

    it 'has distances as Array' do
      expect(subject.distances).to be_a(Array)
    end
  end

  describe '.create_new' do
    subject { instance.create_new(distance) }

    let(:instance) { Path.new }
    let(:distance) { Distance.new({origin: 'A', destination: 'B', kilometers: 10}) }

    it 'returns a instance of path' do
      is_expected.to be_a(Path)
    end

    it 'returns a new instance' do
      is_expected.not_to eq(instance)
    end

    it 'adds attribute in distances array' do
      expect(subject.distances).to eq([distance])
    end

    context 'when distances has one' do
      let(:distance_old) { Distance.new({origin: 'B', destination: 'C', kilometers: 15}) }

      before do
        instance.distances << distance_old
      end

      it 'adds previous distancies with the new distance' do
        expect(subject.distances.count).to eq(2)
      end

      it 'keeps the order' do
        expect(subject.distances).to eq([distance_old, distance])
      end
    end
  end

  describe '.distance' do
    subject { instance.distance }

    let(:instance) { Path.new }

    context 'when has one distance' do
      let(:distance) { Distance.new({origin: 'A', destination: 'B', kilometers: kilometers}) }

      before do
        instance.distances << distance
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
      let(:distance1) { Distance.new({origin: 'A', destination: 'B', kilometers: 10}) }
      let(:distance2) { Distance.new({origin: 'B', destination: 'C', kilometers: 15}) }

      before do
        instance.distances << distance1
        instance.distances << distance2
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
        instance.distances << Distance.new({origin: 'A', destination: 'B', kilometers: 10})
      end

      it 'returns "B"' do
        is_expected.to eq('B')
      end
    end

    context 'when has two distances' do
      before do
        instance.distances << Distance.new({origin: 'A', destination: 'B', kilometers: 10})
        instance.distances << Distance.new({origin: 'A', destination: 'C', kilometers: 10})
      end

      it 'returns the last' do
        is_expected.to eq('C')
      end
    end
  end
end
