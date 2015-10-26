Apipie.configure do |config|
  config.app_name                = "MovieProject"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.app_info                = "The following is the documentation for the Movie Project. Each request must have these additional headers (except wherever mentioned):
                                    X-CLIENT-API-TOKEN - The unique api token for identification of valid api request.
                                    Content-Type - application/json
                                    Accept - application/json"
end
