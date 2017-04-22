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

  describe '.remove_path' do
    subject { instance.remove_path(path) }

    let(:instance) { described_class.new('A', 'B') }
    let(:path) { Path.new }

    context 'when one path' do
      before do
        instance.paths << path
      end

      it 'deletes the path' do
        subject
        expect(instance.paths).to eq([])
      end
    end

    context 'when has two paths' do
      before do
        instance.paths << path
        instance.paths << Path.new
      end

      it 'deletes only one' do
        subject
        expect(instance.paths.count).to eq(1)
      end
    end
  end

  describe '.shortest_path' do
    subject { instance.shortest_path }

    let(:instance) { described_class.new('A', 'C') }

    context 'when has no option' do
      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'when has one option' do
      let(:path) { double(:path, distance: 5) }

      before do
        instance.paths << path
      end

      it 'retuns unique option' do
        is_expected.to eq(path)
      end
    end

    context 'when has two options' do
      let(:short_path) { double(:short_path, distance: 1) }
      let(:long_path) { double(:long_path, distance: 10) }

      before do
        instance.paths << short_path
        instance.paths << long_path
      end

      it 'retuns the shortest path' do
        is_expected.to eq(short_path)
      end
    end
  end
end
