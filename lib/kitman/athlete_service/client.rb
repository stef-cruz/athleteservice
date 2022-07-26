# frozen_string_literal: true

require './lib/kitman/athlete_service/constants'
require './lib/kitman/athlete_service/apis/athlete'
require './lib/kitman/athlete_service/connection'
require 'faraday'
require 'faraday_middleware'
require 'byebug'
require 'json'

module Kitman
  module AthleteServiceAPI
    # Initialize API call
    class Client
      include(::Kitman::AthleteService::Connection)
      include(::Kitman::AthleteService::Constants)
      include(::Kitman::AthleteService::Apis::Athlete)

      attr_reader(:client_id, :client_secret)

      def initialize(client_id:, client_secret:)
        raise Exception, 'Please ensure credentials are correct.' if client_id.empty? || client_secret.empty?

        @client_id = client_id
        @client_secret = client_secret
      end
    end
  end
end