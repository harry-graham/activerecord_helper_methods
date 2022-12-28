# frozen_string_literal: true

require_relative "lib/active_record/helper_methods/version"

Gem::Specification.new do |spec|
  spec.name          = "activerecord_helper_methods"
  spec.version       = ActiveRecord::HelperMethods::VERSION
  spec.authors       = ["Harry Graham"]
  spec.email         = ["harry.graham.595@gmail.com"]

  spec.summary       = "Allows easy adding of helper methods for ActiveRecord models."
  spec.description    = <<-DESC
    Allows easy adding of helper methods for ActiveRecord models.
    See usage for examples: https://github.com/harry-graham/activerecord_helper_methods#usage
  DESC
  spec.homepage      = "https://github.com/harry-graham/activerecord_helper_methods"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/harry-graham/activerecord_helper_methods"
  spec.metadata["changelog_uri"] = "https://github.com/harry-graham/activerecord_helper_methods/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 6.1"

  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", ">= 0"
  spec.add_development_dependency "database_cleaner-active_record", ">= 0"
end
