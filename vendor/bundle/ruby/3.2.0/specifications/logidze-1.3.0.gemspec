# -*- encoding: utf-8 -*-
# stub: logidze 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "logidze".freeze
  s.version = "1.3.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "http://github.com/palkan/logidze/issues", "changelog_uri" => "https://github.com/palkan/logidze/blob/master/CHANGELOG.md", "documentation_uri" => "http://github.com/palkan/logidze", "homepage_uri" => "http://github.com/palkan/logidze", "source_code_uri" => "http://github.com/palkan/logidze" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["palkan".freeze]
  s.date = "2024-01-09"
  s.description = "PostgreSQL JSONB-based model changes tracking".freeze
  s.email = ["dementiev.vm@gmail.com".freeze]
  s.homepage = "http://github.com/palkan/logidze".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.5.5".freeze
  s.summary = "PostgreSQL JSONB-based model changes tracking".freeze

  s.installed_by_version = "3.5.5".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<railties>.freeze, [">= 6.0".freeze])
  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 6.0".freeze])
  s.add_development_dependency(%q<ammeter>.freeze, ["~> 1.1.3".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 1.10".freeze])
  s.add_development_dependency(%q<fx>.freeze, ["~> 0.5".freeze])
  s.add_development_dependency(%q<pg>.freeze, [">= 1.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 13.0".freeze])
  s.add_development_dependency(%q<rspec-rails>.freeze, [">= 4.0".freeze])
  s.add_development_dependency(%q<timecop>.freeze, ["~> 0.8".freeze])
end
