# frozen_string_literal: true

# Load gems
require "pry"
require "active_record"
require "database_cleaner-active_record"

# Load lib files
require "active_record/helper_methods"

# Spec configuration
require "config/setup"
require "config/database_cleaner"

# Set up fixtures
require "fixtures/setup"
