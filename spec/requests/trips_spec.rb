require 'rails_helper'

RSpec.describe 'Trips API', type: :request do
  let!(:trips) { create_list(:trip, 10) }
  let(:trip_id) { trips.first.id }
  let(:user) { create(:user) }

  describe 'GET /trips' do
    before { get '/trips' }

    it 'returns a list of trips' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /trips/:id' do
    before { get "/trips/#{trip_id}" }

    context 'when the record exists' do
      it 'returns the trip' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(trip_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:trip_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Trip/)
      end
    end
  end

  describe 'POST /trips' do
    let(:valid_attributes) { { title: 'Nepal 2018', from: '2018-10-04', to: '2018-10-20', description: 'Hiking the Everest base camp trail.', user_id: user.id } }

    context 'when the request is valid' do
      before { post '/trips', params: valid_attributes }

      it 'creates a trip' do
        expect(json['title']).to eq('Nepal 2018')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/trips', params: { title: 'Europe', from: '2016-04-14', user_id: user.id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure error message' do
        expect(response.body).to match(/Validation failed: To can't be blank/)
      end
    end
  end

  describe 'PATCH /trips/:id' do
    let(:valid_attributes) { { title: 'Italy' } }

    before { patch "/trips/#{trip_id}", params: valid_attributes }

    context 'when the trip exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the trip' do
        updated_trip = Trip.find(trip_id)
        expect(updated_trip.title).to eq('Italy')
      end
    end

    context 'when the trip does not exist' do
      let(:trip_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Trip/)
      end
    end
  end

  describe 'DELETE /trips/:id' do
    before { delete "/trips/#{trip_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
