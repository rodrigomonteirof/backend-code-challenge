require 'rails_helper'

describe RouteService do
  let(:instance) { described_class.new('A', 'C') }

  describe '.new' do
    subject { instance }

    it 'sets origin' do
      expect(subject.origin).to eq('A')
    end

    it 'sets destination' do
       expect(subject.destination).to eq('C')
    end

    it 'has path as an Array' do
      expect(subject.paths).to be_a(Array)
    end
  end

  describe '.find_shortest' do
    subject { instance.find_shortest }

    let(:instance) { described_class.new('A', 'C') }

    context 'when needs only one step' do
      context 'and only one distance' do
        before do
          Distance.create({origin: 'A', destination: 'C', kilometers: 5})
        end

        it 'returns path' do
          expect(subject.distance).to eq(5)
        end
      end

      context 'and two distances' do
        before do
          Distance.create({origin: 'A', destination: 'C', kilometers: 5})
          Distance.create({origin: 'A', destination: 'B', kilometers: 10})
        end

        it 'returns path with less kilometers' do
          expect(subject.distance).to eq(5)
        end
      end
    end

    context 'when needs more than one step' do
      before do
        Distance.create({origin: 'A', destination: 'B', kilometers: 10})
        Distance.create({origin: 'B', destination: 'C', kilometers: 15})
        Distance.create({origin: 'A', destination: 'C', kilometers: 30})
      end

      it 'returns path with less kilometers' do
        expect(subject.distance).to eq(25)
      end
    end
  end
end
