# frozen_string_literal: true

module ActiveRecord
  module HelperMethods
    module FinderMethods
      def add_finder_methods(column:, values:)
        validate_column_param(column)
        validate_values_param(values)

        values.each do |value|
          define_finder_method(column, value)
        end
      end

      private

      def validate_column_param(column)
        return if column.is_a?(Symbol)

        raise StandardError.new("Invalid column value - must be a symbol")
      end

      def validate_values_param(values)
        return if values.is_a?(Array) && values.all? { |v| v.is_a?(String) }

        raise StandardError.new("Invalid values - must be an array of strings")
      end

      def define_finder_method(column, value)
        define_singleton_method "#{value}" do
          where("#{column} == '#{value}'")
        end
      end
    end
  end
end
