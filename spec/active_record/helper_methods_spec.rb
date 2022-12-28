# frozen_string_literal: true

RSpec.describe ActiveRecord::HelperMethods do
  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end
end
