# frozen_string_literal: true

RSpec.describe ActiveRecord::HelperMethods::AccessorMethods do
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
        class InvalidModel < ActiveRecord::Base
          add_accessor_methods column: 1, values: %w[one two three]
        end
      end.to raise_error(
        StandardError,
        "Invalid column value - must be a symbol"
      )
    end

    it "raises an error if values argument is invalid" do
      expect do
        class InvalidModel < ActiveRecord::Base
          add_accessor_methods column: :status, values: ['one', :two, 3]
        end
      end.to raise_error(
        StandardError,
        "Invalid values - must be an array of strings"
      )
    end
  end
end
