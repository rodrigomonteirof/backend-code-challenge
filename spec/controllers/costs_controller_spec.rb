require 'rails_helper'

describe CostsController do
  describe 'GET show' do
    subject { get :show, params: params }

    context 'when params is valid' do
      let(:params) { { origin: 'A', destination: 'C', weight: weight } }

      before do
        Distance.create({origin: 'A', destination: 'B', kilometers: 10})
        Distance.create({origin: 'B', destination: 'C', kilometers: 15})
        Distance.create({origin: 'A', destination: 'C', kilometers: 30})
      end

      context 'when weight is 5' do
        let(:weight) { 5 }

        it 'returns code 200' do
          subject
          expect(response.code).to eq('200')
        end

        it 'returns calculated cost' do
          subject
          expect(response.body).to eq('{"cost":18.75}')
        end
      end

      context 'when weight is 10' do
        let(:weight) { 10 }

        it 'returns code 200' do
          subject
          expect(response.code).to eq('200')
        end

        it 'returns calculated cost' do
          subject
          expect(response.body).to eq('{"cost":37.5}')
        end
      end
    end

    context 'when weight is too high' do
      let(:params) { { origin: 'A', destination: 'C', weight: 51 } }

      it 'returns code 422' do
        subject
        expect(response.code).to eq('422')
      end

      it 'returns error message' do
        subject
        expect(response.body).to eq('{"weight":["is not included in the list"]}')
      end
    end

    context 'when weight is too low' do
      let(:params) { { origin: 'A', destination: 'C', weight: 0 } }

      it 'returns code 422' do
        subject
        expect(response.code).to eq('422')
      end

      it 'returns error message' do
        subject
        expect(response.body).to eq('{"weight":["is not included in the list"]}')
      end
    end

    context 'when path doesnt exist' do
      let(:params) { { origin: 'A', destination: 'Z', weight: 5 } }

      it 'returns code 404' do
        subject
        expect(response.code).to eq('404')
      end

      it 'returns error message' do
        subject
        expect(response.body).to eq('{"error":"Path not found"}')
      end
    end
  end
end
