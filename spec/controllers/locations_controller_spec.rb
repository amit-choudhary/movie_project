require 'rails_helper'

describe LocationsController do
  let!(:location) { FactoryGirl.create(:location) }
  let!(:movie) { FactoryGirl.create(:movie) }

  before do
    movie.locations << location
  end

  def get_all
    get :all
  end

  def get_movies
    get :movies, { id: location.id }
  end

  describe '#all' do
    context 'when api token is not valid' do
      before do
        request.headers['X-CLIENT-API-TOKEN'] = 'test'
      end

      it 'returns unauthorized message' do
        get :all, nil
        @expected = {
          message: 'Not authorized'
        }
        expect(response.body).to eq(@expected.to_json)
      end

      it 'returns 401 as status' do
        get :all, nil
        expect(response.status).to eq(401)
      end
    end

    context 'when api token is valid' do
      before do
        request.headers['X-CLIENT-API-TOKEN'] = CLIENT_API_TOKEN
      end

      it 'returns expected response' do
        get_all
        @expected = [
          {
            id: location.id,
            name: location.name
          }
        ]
        expect(response.body).to eq(@expected.to_json)
      end

      it 'returns 200 as status' do
        get :all, nil
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#movies' do
    context 'when api token is not valid' do
      before do
        request.headers['X-CLIENT-API-TOKEN'] = 'test'
      end

      it 'returns unauthorized message' do
        get_movies
        @expected = {
          message: 'Not authorized'
        }
        expect(response.body).to eq(@expected.to_json)
      end

      it 'returns 401 as status' do
        get_movies
        expect(response.status).to eq(401)
      end
    end

    context 'when api token is valid' do
      before do
        request.headers['X-CLIENT-API-TOKEN'] = CLIENT_API_TOKEN
      end

      context 'when location is not loaded successfully' do
        before do
          expect(Location).to receive(:where) { [] }
        end

        it 'returns not found message' do
          get_movies
          @expected = {
            message: 'Location not found'
          }
          expect(response.body).to eq(@expected.to_json)
        end

        it 'returns 404 as status' do
          get_movies
          expect(response.status).to eq(404)
        end
      end

      context 'when location is loaded successfully' do
        it 'returns expected response' do
          get_movies
          @expected = [
            {
              movies: [
                {
                  id: movie.id,
                  title: movie.title
                }
              ]
            }
          ]
          expect(response.body).to eq(@expected.to_json)
        end

        it 'returns 200 as status' do
          get_movies
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
