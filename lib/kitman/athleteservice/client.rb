require "./lib/kitman/athleteservice/constants"
require "./lib/kitman/athleteservice/apis/athlete"
require "./lib/kitman/athleteservice/connection"
require "faraday"
require "faraday_middleware"
require "byebug"
require "json"

module Kitman
  module AthleteService
    class Client

      include(::Kitman::AthleteService::Connection)
      include(::Kitman::AthleteService::Constants)
      include(::Kitman::AthleteService::Apis::Athlete)

      attr_reader(:client_id, :client_secret)

      def initialize(client_id:, client_secret:)
        if client_id.empty? || client_secret.empty?
          raise Exception.new "Please ensure credentials are correct."
        else
          @client_id = client_id
          @client_secret = client_secret
        end
      end

    end
  end
end
