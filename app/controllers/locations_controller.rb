class LocationsController < ApplicationController

  before_action :authorize_api_key!, only: [:movies, :all]
  before_action :load_location, only: :movies

  api :GET, '/locations/:id/movies', 'It returns all movies corresponding to a particular location'
  description <<-EOS
    Sucess:
      It returns id and name of all movies of a location.
      Response -
        [
          {
            "movies": [
              {
                "id": 30,
                "title": "Big Eyes"
              }
            ]
          }
        ]
    Errors:
      1. When 'X-CLIENT-API-TOKEN' does not match it returns status 401.
        Response-
          {
            'message': 'Not authorized.'
          }
      2. When location is not found it returns status 404.
        Response-
          {
            'message': 'Location not found.'
          }
  EOS
  formats ['json']
  error 401, "When 'X-CLIENT-API-TOKEN' does not match"
  error 404, 'When location not found'
  def movies
    render json: @location.to_json(only: [], include: { movies: { only: [:id, :title] } })
  end

  api :GET, '/locations/all', 'It returns all locations.'
  description <<-EOS
    Sucess:
      It returns id and name of all locations.
      Response -
        [
          {
            "id": 1,
            "name": "City Hall"
          },
          {
            "id": 2,
            "name": "Epic Roasthouse (399 Embarcadero)"
          }
        ]
    Errors:
      1. When 'X-CLIENT-API-TOKEN' does not match it returns status 401.
        Response-
          {
            'message': 'Not authorized.'
          }
  EOS
  formats ['json']
  error 401, "When 'X-CLIENT-API-TOKEN' does not match"
  def all
    render json: Location.all.to_json(only: [:id, :name])
  end

  private
    def load_location
      @location = Location.where(id: params[:id])
      unless @location.first
        render json: { message: 'Location not found' }, status: :not_found
      end
    end
end
