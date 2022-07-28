# frozen_string_literal: true

require 'athlete_service/version'
require 'athlete_service/constants'
require 'athlete_service/client'
require 'athlete_service/apis/athlete'

module AthleteServiceAPI
  class Error < StandardError; end
end
