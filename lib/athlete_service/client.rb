# frozen_string_literal: true

require './lib/athlete_service/constants'
require './lib/athlete_service/apis/athlete'
require './lib/athlete_service/connection'
require 'faraday'
require 'byebug'
require 'json'

module AthleteServiceAPI
  # Initialize API call
  class Client
    include(::AthleteServiceAPI::Connection)
    include(::AthleteServiceAPI::Constants)
    include(::AthleteServiceAPI::Apis::Athlete)

    attr_reader(:client_id, :client_secret)

    def initialize(client_id:, client_secret:)
      raise Exception, 'Please ensure credentials are correct.' if client_id.empty? || client_secret.empty?

      @client_id = client_id
      @client_secret = client_secret
    end
  end
end