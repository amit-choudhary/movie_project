class MoviesController < ApplicationController

  before_action :authorize_api_key!, only: [:locations, :all]
  before_action :load_movie, only: :locations

  api :GET, '/movies/:id/locations', 'It returns all locations corresponding to a particular movie'
  description <<-EOS
    Sucess:
      It returns id and name of all locations of a movie.
      Response -
        [
          {
            "locations": [
              {
                "id": 1,
                "name": "City Hall"
              },
              {
                "id": 2,
                "name": "Epic Roasthouse (399 Embarcadero)"
              }
            }
          ]
    Errors:
      1. When 'X-CLIENT-API-TOKEN' does not match it returns status 401.
        Response-
          {
            'message': 'Not authorized.'
          }
      2. When movie is not found it returns status 404.
        Response-
          {
            'message': 'Movie not found.'
          }
  EOS
  formats ['json']
  error 401, "When 'X-CLIENT-API-TOKEN' does not match"
  error 404, 'When location not found'
  def locations
    render json: @movie.to_json(only: [], include: { locations: { only: [:id, :name] } })
  end

  api :GET, '/movies/all', 'It returns all movies.'
  description <<-EOS
    Sucess:
      It returns id and name of all movies.
      Response -
        [
          {
            "id": 1,
            "title": "180"
          },
          {
            "id": 2,
            "title": "24 Hours on Craigslist"
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
    render json: Movie.all.to_json(only: [:id, :title])
  end

  private

    def load_movie
      @movie = Movie.where(id: params[:id])
      unless @movie.first
        render json: { message: 'Movie not found' }, status: :not_found
      end
    end

end
