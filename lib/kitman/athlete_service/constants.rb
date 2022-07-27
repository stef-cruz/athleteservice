# frozen_string_literal: true

module Kitman
  module AthleteServiceAPI
    # Define constants
    module Constants
      JWT_TOKEN_ENDPOINT = ENV.fetch('JWT_TOKEN_ENDPOINT', 'https://dev-0erpan4x.us.auth0.com/oauth/token')
      API_ENDPOINT = ENV.fetch('API_ENDPOINT', 'https://athletedataservice.azurewebsites.net')
    end
  end
end