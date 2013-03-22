require "bundler"
Bundler.setup(:default)

require "jeweler"

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "database_resetter"
  gemspec.summary = "Automatically resets your database when migrations change"
  gemspec.email = "ashley.moran@patchspace.co.uk"
  gemspec.homepage = "https://patch-tag.com/repo/ashleymoran/database_resetter/"
  gemspec.authors = ["Ashley Moran"]
  
  gemspec.files.include %w[
    config/**/*
    lib/**/*
    *.markdown
    Gemfile
    Rakefile
    VERSION
  ]
  gemspec.test_files.include %w[
    features/**/*
    spec/**/*
  ]
end

Jeweler::GemcutterTasks.new