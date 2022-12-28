# frozen_string_literal: true

RSpec.describe ActiveRecord::HelperMethods::ModelHelperMethods do
  let(:ticket_not_started) { ModelWithAccessorMethods.new(status: "not_started") }
  let(:ticket_in_progress) { ModelWithAccessorMethods.new(status: "in_progress") }
  let(:ticket_completed) { ModelWithAccessorMethods.new(status: "completed") }

  describe "add_accessor_methods" do
    it "defines accessor methods for each value", :aggregate_failures do
      expect(ticket_not_started.not_started?).to eq(true)
      expect(ticket_not_started.in_progress?).to eq(false)
      expect(ticket_not_started.completed?).to eq(false)

      expect(ticket_in_progress.not_started?).to eq(false)
      expect(ticket_in_progress.in_progress?).to eq(true)
      expect(ticket_in_progress.completed?).to eq(false)

      expect(ticket_completed.not_started?).to eq(false)
      expect(ticket_completed.in_progress?).to eq(false)
      expect(ticket_completed.completed?).to eq(true)
    end

    it "raises an error if column argument is invalid" do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: 1, values: %w[one two three]
        end
      end.to raise_error(
        StandardError,
        "Invalid column value - must be a column on this table"
      )
    end

    it "does not raise an error if column argument is a symbol (and is a column of the table)" do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: :status, values: %w[one two three]
        end
      end.not_to raise_error
    end

    it "does not raise an error if column argument is a string (and is a column of the table)" do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: "status", values: %w[one two three]
        end
      end.not_to raise_error
    end

    it "raises an error if values argument is invalid" do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: :status, values: ['one', :two, 3]
        end
      end.to raise_error(
        StandardError,
        "Invalid values - must be an array of strings or symbols"
      )
    end

    it "does not raise an error if values argument is an array of strings"  do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: "status", values: %w[one two three]
        end
      end.not_to raise_error
    end

    it "does not raise an error if values argument is an array of symbols"  do
      expect do
        class Ticket < ActiveRecord::Base
          add_accessor_methods column: "status", values: %i[one two three]
        end
      end.not_to raise_error
    end
  end
end
