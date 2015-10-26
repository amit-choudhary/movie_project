class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
    def authorize_api_key!
      unless request.headers['X-CLIENT-API-TOKEN'] == CLIENT_API_TOKEN
        render json: { message: 'Not authorized' }, status: :unauthorized
      end
    end
end
