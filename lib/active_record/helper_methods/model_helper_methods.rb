# frozen_string_literal: true

module ActiveRecord
  module HelperMethods
    module ModelHelperMethods
      def add_helper_methods(column:, values:)
        validate_params(column: column, values: values)

        values.each do |value|
          define_accessor_method(column, value)
          define_finder_method(column, value)
        end
      end

      def add_accessor_methods(column:, values:)
        validate_params(column: column, values: values)

        values.each do |value|
          define_accessor_method(column, value)
        end
      end

      def add_finder_methods(column:, values:)
        validate_params(column: column, values: values)

        values.each do |value|
          define_finder_method(column, value)
        end
      end

      private

      def define_accessor_method(column, value)
        define_method "#{value}?" do
          send(column) == value
        end
      end

      def define_finder_method(column, value)
        define_singleton_method "#{value}" do
          where("#{column} == '#{value}'")
        end
      end

      # --- Validations --------------------------------------------------------

      def validate_params(column:, values:)
        validate_column_param(column)
        validate_values_param(values)
      end

      def validate_column_param(column)
        return if column.is_a?(Symbol)

        raise StandardError.new("Invalid column value - must be a symbol")
      end

      def validate_values_param(values)
        return if values.is_a?(Array) && values.all? { |v| v.is_a?(String) }

        raise StandardError.new("Invalid values - must be an array of strings")
      end
    end
  end
end
