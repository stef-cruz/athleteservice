# Athleteservice

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/athleteservice`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'athleteservice'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install athleteservice

## Usage

Instantiate the class:  
client = AthleteService::Client.new  

Call methods:  
client.get_token

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Debugging/Testing with IRB

- Type `irb` in the console
- Load the file you want to debug e.g. `load './lib/athleteservice/client.rb'`. Note: you have to load the file for every change you make to the file

If you want to debug:
- Add `byebug` to your gemspec file
- Run `bundle install` to install the gem
- Add `require 'byebug'` to the top of the file you want to debug
- Comment `byebug` anywhere you want the debugger to stop

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stef-cruz/athleteservice.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
