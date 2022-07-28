# frozen_string_literal: true

require 'byebug'
require 'logger'

module AthleteServiceAPI
  # Get token and init connection to the API
  module Connection
    def access_token
      conn = Faraday.new(url: 'https://dev-0erpan4x.us.auth0.com/oauth/token',
                         headers: { 'Content-Type' => 'application/json' }) do |faraday|
        faraday.response(:logger, ::Logger.new($stdout), bodies: true)
      end

      response = conn.post('') do |req|
        req.body = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'client_credentials',
          audience: 'https://athletedataservice.thesportsoffice.com'
        }.to_json
      end
      response_body = JSON.parse(response&.body || {})
      response_body['access_token']
    end

    def connection
      jwt_token = access_token
      Faraday.new(url: ::AthleteServiceAPI::Constants::API_ENDPOINT.to_s,
                  headers: { 'Content-Type' => 'application/json',
                             'Authorization' => "Bearer #{jwt_token}" }) do |faraday|
        faraday.response(:logger, ::Logger.new($stdout), bodies: true)
      end
    end
  end
end