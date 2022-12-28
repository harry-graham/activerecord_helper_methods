# frozen_string_literal: true

RSpec.describe ActiveRecord::HelperMethods::ModelHelperMethods do
  describe "add_helper_methods" do
    let(:ticket_not_started) { ModelWithHelperMethods.create!(status: "not_started") }
    let(:ticket_in_progress) { ModelWithHelperMethods.create!(status: "in_progress") }
    let(:ticket_completed) { ModelWithHelperMethods.create!(status: "completed") }

    it "defines finder methods for each value", :aggregate_failures do
      # Initialise tickets
      [ticket_not_started, ticket_in_progress, ticket_completed]

      expect(ModelWithHelperMethods.not_started).to match_array(ticket_not_started)
      expect(ModelWithHelperMethods.in_progress).to match_array(ticket_in_progress)
      expect(ModelWithHelperMethods.completed).to match_array(ticket_completed)
    end

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
          add_helper_methods column: 1, values: %w[one two three]
        end
      end.to raise_error(
        StandardError,
        "Invalid column value - must be a symbol"
      )
    end

    it "raises an error if values argument is invalid" do
      expect do
        class InvalidModel < ActiveRecord::Base
          add_helper_methods column: :status, values: ['one', :two, 3]
        end
      end.to raise_error(
        StandardError,
        "Invalid values - must be an array of strings"
      )
    end
  end
end
