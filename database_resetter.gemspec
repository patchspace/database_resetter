# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "database_resetter"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ash Moran"]
  s.date = "2013-04-04"
  s.email = "ash.moran@patchspace.co.uk"
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "HISTORY.markdown",
    "LICENCE.markdown",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "config/cucumber.yml",
    "database_resetter.gemspec",
    "database_resetter.sublime-project",
    "features/descriptions/change_environment.feature",
    "features/descriptions/database_resetter.feature",
    "features/descriptions/different_web_frameworks.feature",
    "features/descriptions/no_migrations.feature",
    "features/step_definitions/database_resetter_steps.rb",
    "features/support/env.rb",
    "lib/database_resetter.rb"
  ]
  s.homepage = "https://github.com/patchspace/database_resetter"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Automatically resets your database when migrations change"
  s.test_files = ["features/descriptions", "features/descriptions/change_environment.feature", "features/descriptions/database_resetter.feature", "features/descriptions/different_web_frameworks.feature", "features/descriptions/no_migrations.feature", "features/step_definitions", "features/step_definitions/database_resetter_steps.rb", "features/support", "features/support/env.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<ap>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<ap>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<ap>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

