# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

ActiveRecord::Schema.define do
  create_table :tickets, force: true do |t|
    t.string :status
  end
end

class Ticket < ActiveRecord::Base
  STATUSES = %w[not_started in_progress completed]
end

class ModelWithAccessorMethods < Ticket
  add_accessor_methods column: :status, values: STATUSES
end

class ModelWithFinderMethods < Ticket
  add_finder_methods column: :status, values: STATUSES
end

class ModelWithHelperMethods < Ticket
  add_helper_methods column: :status, values: STATUSES
end
