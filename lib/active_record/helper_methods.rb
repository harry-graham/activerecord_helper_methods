# frozen_string_literal: true

module ActiveRecord
  module HelperMethods
    extend ActiveSupport::Autoload

    autoload :AccessorMethods
    autoload :FinderMethods
    autoload :ModelHelperMethods
    autoload :VERSION
  end
end

ActiveSupport.on_load(:active_record) do
  extend ActiveRecord::HelperMethods::AccessorMethods
  extend ActiveRecord::HelperMethods::FinderMethods
  extend ActiveRecord::HelperMethods::ModelHelperMethods
end
