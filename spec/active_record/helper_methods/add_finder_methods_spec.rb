# frozen_string_literal: true

RSpec.describe ActiveRecord::HelperMethods::ModelHelperMethods do
  let(:ticket_not_started) { ModelWithFinderMethods.create!(status: "not_started") }
  let(:ticket_in_progress) { ModelWithFinderMethods.create!(status: "in_progress") }
  let(:ticket_completed) { ModelWithFinderMethods.create!(status: "completed") }

  describe "add_finder_methods" do
    it "defines finder methods for each value", :aggregate_failures do
      # Initialise tickets
      [ticket_not_started, ticket_in_progress, ticket_completed]

      expect(ModelWithFinderMethods.not_started).to match_array(ticket_not_started)
      expect(ModelWithFinderMethods.in_progress).to match_array(ticket_in_progress)
      expect(ModelWithFinderMethods.completed).to match_array(ticket_completed)
    end

    it "raises an error if column argument is invalid" do
      expect do
        class InvalidModel < ActiveRecord::Base
          add_finder_methods column: 1, values: %w[one two three]
        end
      end.to raise_error(
        StandardError,
        "Invalid column value - must be a symbol"
      )
    end

    it "raises an error if values argument is invalid" do
      expect do
        class InvalidModel < ActiveRecord::Base
          add_finder_methods column: :status, values: ['one', :two, 3]
        end
      end.to raise_error(
        StandardError,
        "Invalid values - must be an array of strings"
      )
    end
  end
end
