require "faraday"
require "faraday_middleware"
require "byebug"
require "json"


module AthleteService
  class Client

    attr_reader(:client_id, :client_secret)

    # Initialize a new AthleteService integration with the given +client_id+ and +client_secret+.

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def get_token
      conn = Faraday.new(url:'https://dev-0erpan4x.us.auth0.com',
                         headers: {'Content-Type' => 'application/x-www-form-urlencoded'})

      response = conn.post('/oauth/token') do |req|
        req.body = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'client_credentials',
          audience: 'https://athletedataservice.thesportsoffice.com'
        }
      end
      response_body = JSON.parse(response&.body || {})
      api_token = response_body['access_token']
    end

    def get_data
      # get token calling the previous function
      jwt_token = get_token
      conn = Faraday.new(url:'https://athletedataservice.azurewebsites.net',
                         headers: {'Content-Type' => 'application/json'})
      response = conn.get('/summary') do |req|
        req.headers = {
          "Authorization" => "Bearer #{jwt_token}"
        }
      end
      data = JSON.parse(response&.body || {})
    end
  end
end