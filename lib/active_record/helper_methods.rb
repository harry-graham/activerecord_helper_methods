# frozen_string_literal: true

module ActiveRecord
  module HelperMethods
    extend ActiveSupport::Autoload

    autoload :AccessorMethods
    autoload :VERSION
  end
end

ActiveSupport.on_load(:active_record) do
  extend ActiveRecord::HelperMethods::AccessorMethods
end
