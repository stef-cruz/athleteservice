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
      end
    end
  end
end
