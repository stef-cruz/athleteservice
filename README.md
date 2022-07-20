# Athleteservice

Gem to get data from AthleteService API.

```ruby
    client = AthleteService::Client.new(
         client_id: 'CLIENT_ID',
         client_secret: 'CLIENT_SECRET'
    )
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'athleteservice'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install athleteservice


## Debugging/Testing with IRB

- Type `irb` in the console
- Load the file you want to debug e.g. `load './lib/athleteservice/client.rb'`. Note: you have to load the file for every change you make to the file

If you want to debug:
- Add `byebug` to your gemspec file
- Run `bundle install` to install the gem
- Add `require 'byebug'` to the top of the file you want to debug
- Comment `byebug` anywhere you want the debugger to stop
