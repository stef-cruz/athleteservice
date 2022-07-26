# frozen_string_literal: true

require 'athleteservice/version'
require 'athleteservice/constants'
require 'athleteservice/client'
require 'athleteservice/apis/athlete'

module Kitman
  module AthleteService
    class Error < StandardError; end
  end
end