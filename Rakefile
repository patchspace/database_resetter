require 'jeweler'
require 'jeweler/rubygems_tasks'

Jeweler::Tasks.new do |gem|
  gem.name = "database_resetter"
  gem.summary = "Automatically resets your database when migrations change"
  gem.email = "ash.moran@patchspace.co.uk"
  gem.homepage = "https://github.com/patchspace/database_resetter"
  gem.authors = ["Ash Moran"]

  # Why can't we do `gem.files.include` here???

  gem.files.concat %w[
    config/**/*
    lib/**/*
    *.markdown
    Gemfile
    Rakefile
    VERSION
  ]
  gem.test_files.concat Dir.glob(
    %w[
      features/**/*
      spec/**/*
    ]
  )
end

Jeweler::RubygemsDotOrgTasks.new