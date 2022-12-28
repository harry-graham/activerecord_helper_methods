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

This helper takes a column name and an array of values.

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]

  add_accessor_methods column: :status, values: STATUSES
end
```

Result: it defines an instance method for each value:

```ruby
ticket = Ticket.create!(status: "in_progress")

ticket.not_started?
=> false
ticket.in_progress?
=> true
ticket.completed?
=> false
```

Without the helper, this is more verbose, and requires more maintenance because it would require a new instance method to be added manually whenever a new status is added:

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]

  def not_started?
    status == "not_started"
  end

  def in_progress?
    status == "in_progress"
  end

  def completed?
    status == "completed"
  end
end
```

This can also be done using meta-programming, as this gem does, but this may add unwanted complexity to your project.

### add_finder_methods

This helper takes a column name and an array of values.

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]

  add_finder_methods column: :status, values: STATUSES
end
```

Result: it defines a class method for each value, that filters by that value:

```ruby
ticket_not_started = Ticket.create!(status: "not_started")
ticket_in_progress = Ticket.create!(status: "in_progress")
ticket_completed = Ticket.create!(status: "completed")

Ticket.count
=> 3
Ticket.not_started
# Returns an ActiveRecord::Relation object that contains only ticket_not_started
Ticket.in_progress
# Returns an ActiveRecord::Relation object that contains only ticket_in_progress
Ticket.completed
# Returns an ActiveRecord::Relation object that contains only ticket_completed
```

Each method returns an ActiveRecord::Relation, and so are chainable with any other class methods, e.g.:
```ruby
# Note: open and active are fictional class methods in this example
Ticket.open.not_started.active.count
=> 1
```

Without the helper, this is more verbose, and requires more maintenance because it would require a new class method (scope) to be added manually whenever a new status is added:

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]

  scope :not_started, -> { where(status: "not_started") }
  scope :in_progress, -> { where(status: "in_progress") }
  scope :completed, -> { where(status: "completed") }
end
```

### add_helper_methods

This helper adds both the accessor and finder methods.

It takes a column name and an array of values.

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed blocked archived approved rejected]

  add_helper_methods column: :status, values: STATUSES
end
```

Without the helper, this is significantly more verbose, especially when there are lots of values:

```ruby
class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed blocked archived approved rejected]

  scope :not_started, -> { where(status: "not_started") }
  scope :in_progress, -> { where(status: "in_progress") }
  scope :completed, -> { where(status: "completed") }
  scope :blocked, -> { where(status: "blocked") }
  scope :archived, -> { where(status: "archived") }
  scope :approved, -> { where(status: "approved") }
  scope :rejected, -> { where(status: "rejected") }

  def not_started?
    status == "not_started"
  end

  def in_progress?
    status == "in_progress"
  end

  def completed?
    status == "completed"
  end

  def blocked?
    status == "blocked"
  end

  def archived?
    status == "archived"
  end

  def approved?
    status == "approved"
  end

  def rejected?
    status == "rejected"
  end
end
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
