# frozen_string_literal: true

module ActiveRecord
  module HelperMethods
    module ModelHelperMethods
      def add_helper_methods(column:, values:)
        add_accessor_methods(column: column, values: values)
        add_finder_methods(column: column, values: values)
      end
    end
  end
end
