# frozen_string_literal: true

module AthleteServiceAPI
  class Error < StandardError; end
  autoload :Constants, 'athlete_service/constants'
  autoload :AthletesAPI, 'athlete_service/apis/athlete'
  autoload :Connection, 'athlete_service/connection'
end
