# ActiveRecord Helper Methods

A quick and easy way to add certain types of helper methods to your models.

## Currently supported
- Finder methods
- Accessor methods

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord_helper_methods'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install activerecord_helper_methods

## Usage

### add_accessor_methods

This helper takes a column name and an array of values, and defines an instance method for each value.

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]

  add_accessor_methods column: :status, values: STATUSES
end

ticket = Ticket.create!(status: "in_progress")

ticket.not_started?
=> false
ticket.in_progress?
=> true
ticket.completed?
=> false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/harry-graham/activerecord_helper_methods. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/harry-graham/activerecord_helper_methods/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/harry-graham/activerecord_helper_methods/blob/master/CODE_OF_CONDUCT.md).
