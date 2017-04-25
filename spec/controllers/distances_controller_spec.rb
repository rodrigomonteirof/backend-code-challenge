require 'rails_helper'

describe DistancesController do
  describe 'POST create' do
    subject { post :create, params: params }

    context 'when params is valid' do
      let(:params) { { origin: 'A', destination: 'B', kilometers: '10' } }

      it 'returns code 201' do
        subject
        expect(response.code).to eq('201')
      end

      it 'persists on database' do
        subject
        expect(Distance.count).to eq(1)
      end

      it 'returns a json with distance' do
        subject
        expect(response.body).to eq(Distance.first.to_json)
      end

      context 'and distance already exist' do
        before do
          Distance.new({ origin: 'A', destination: 'B', kilometers: '1' }).save
        end

        it 'doesnt insert on database' do
          subject
          expect(Distance.count).to eq(1)
        end

        it 'updates kilometers value' do
          subject
          expect(Distance.first.kilometers).to eq(10)
        end
      end

      context 'and exist other distance' do
        before do
          post :create, params: { origin: 'B', destination: 'C', kilometers: '15' }
        end

        it 'persists on database' do
          subject
          expect(Distance.count).to eq(2)
        end
      end
    end

    context 'when params is invalid' do
      let(:params) { { origin: 'A', destination: 'B', kilometers: '0' } }

      it 'returns code 422' do
        subject
        expect(response.code).to eq('422')
      end

      it 'retusn a josn with error' do
        subject
        expect(response.body).to eq('{"kilometers":["is not included in the list"]}')
      end
    end
  end
end
