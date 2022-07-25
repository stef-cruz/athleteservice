# frozen_string_literal: true

module Kitman
  module AthleteService
    module Apis
      # Service to get data from the API
      module Athlete
        # To test the methods:
        # 1. Load client.rb and athlete.rb files in irb
        # 2. Instantiate the client class,
        # i.e. client = Kitman::AthleteService::Client.new(client_id:'x', client_secret:'x')
        # 3. Call all_athletes method in client class, i.e. client.all_athletes

        def all_athletes
          connect_to_api = connection
          response = connect_to_api.get('/summary')
          puts "Failed to connect to the API. Response status: #{response.status}." if response.status != 200
          JSON.parse(response.body || {})
        end

        def athlete_by_name(athlete_name)
          data = all_athletes
          data.select { |i| i['athlete'] == athlete_name }
        end

        def athletes_average_summary
          athletes = []
          data = all_athletes
          data.each do |athlete|
            sum = 0
            count = 0
            # Iterate through summary to calculate average values
            athlete['summary'].each do |metric|
              count += 1
              sum += metric['value']
            end
            average = sum / count
            athletes_data = { 'athlete': athlete['athlete'],
                              'test': athlete['test'],
                              'average': average }
            athletes.append(athletes_data)
          end
          athletes
        end
      end
    end
  end
end
