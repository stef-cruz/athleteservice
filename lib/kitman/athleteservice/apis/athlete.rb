module Kitman
  module AthleteService
    module Apis
      module Athlete
        # To test the methods:
        # 1. Load client.rb and athlete.rb files in irb
        # 2. Instantiate the client class, i.e. client = Kitman::AthleteService::Client.new(client_id:'xxx', client_secret:'xxx')
        # 3. Call all_athletes method in client class, i.e. client.all_athletes

        def all_athletes
          conn = connection
          response = conn.get('/summary')
          JSON.parse(response.body)
        end

        def get_by_athlete(athlete_name)
          data = all_athletes
          data.select {|i| i['athlete'] == athlete_name}
        end

        def get_all_data_with_average_summary
          athletes = []
          data = all_athletes
          data.each do |athlete|
            sum = 0
            count = 0
              # Iterate through summary to calculate average values
              athlete['summary'].each do |metric|
                count += 1
                sum = sum + metric['value']
              end
            average = sum / count
            athletes_data = {'athlete': athlete['athlete'],
                             'test': athlete['test'],
                             'average': average}
            athletes.append(athletes_data)
          end
          athletes
        end
      end
    end
  end
end
