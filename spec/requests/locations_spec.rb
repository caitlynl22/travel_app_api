require 'rails_helper'

RSpec.describe 'Locations API', type: :request do
  let!(:trip) { create(:trip) }
  let!(:locations) { create_list(:location, 5, trip_ids: [trip.id]) }
  let(:trip_id) { trip.id }
  let(:id) { locations.first.id }

  describe 'GET /trips/:trip_id/locations' do
    before { get "/trips/#{trip_id}/locations" }

    context 'when trip exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all trip locations' do
        expect(json.size).to eq(5)
      end
    end

    context 'when trip does not exist' do
      let(:trip_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Trip/)
      end
    end
  end

  describe 'GET /trips/:trip_id/locations/:id' do
    before { get "/trips/#{trip_id}/locations/#{id}" }

    context 'when trip location exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the location' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when trip location does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Location/)
      end
    end
  end

  describe 'POST /trips/:trip_id/locations' do
    let(:valid_attributes) { { country: 'United States', city: 'Portland', region: 'ME' } }

    context 'when the request is valid' do
      before { post "/trips/#{trip_id}/locations", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates a location' do
        expect(json['city']).to eq('Portland')
      end
    end

    context 'when the request is invalid' do
      before { post "/trips/#{trip_id}/locations", params: { region: 'ME' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Country can't be blank/)
      end
    end
  end

  describe 'PATCH /trips/:trip_id/locations/:id' do
    let(:valid_attributes) { { country: 'Canada' } }

    before { patch "/trips/#{trip_id}/locations/#{id}", params: valid_attributes }

    context 'when the location exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the location' do
        updated_location = Location.find(id)
        expect(updated_location.country).to eq('Canada')
      end
    end

    context 'when the location does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Location/)
      end
    end
  end

  describe 'DELETE /trips/:trip_id/locations/:id' do
    before { delete "/trips/#{trip_id}/locations/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
