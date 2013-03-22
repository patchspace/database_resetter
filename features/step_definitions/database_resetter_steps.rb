module DatabaseResetterHelpers
  def create_project
    create_dir(@project_name)
    cd(@project_name)
    create_fake_test_case
  end
  
  def create_fake_test_case(options = {})
    options = {
      :environment => "unimportant_env",
      :migration_directory => "db/migrate",
      :command_pattern => "rake db:reset RAILS_ENV=%ENV%"
    }.merge(options)
              
    create_file(
      "fake_test_case.rb", <<-RUBY
        require "rubygems"
        require "database_resetter"
        DatabaseResetter.new(
          :environment => "#{options[:environment]}",
          :migration_directory => "#{options[:migration_directory]}",
          :command_pattern => "#{options[:command_pattern]}"
        ).reset_if_required
      RUBY
    )
  end
end
World(DatabaseResetterHelpers)

Given /^an empty project called "([^"]*)"$/ do |project_name|
  @project_name = project_name
  create_project
end

Given /^an empty Rails migration directory$/ do
  create_dir("db/migrate")
end

Given /^a Rails-type project$/ do
  @project_name = "rails-project"
  create_project

  @migration_dir = "db/migrate"
  create_dir(@migration_dir)
  create_file(
    "#{@migration_dir}/001_first_migration.rb", <<-RUBY
      # This is just a dummy migration file
    RUBY
  )    

  create_file(
    "Rakefile", <<-RUBY
      namespace :db do
        task :reset do
          puts "Invoked: rake db:reset RAILS_ENV=\#{ENV['RAILS_ENV']}"
        end
      end
    RUBY
  )
  
  create_fake_test_case
end

Given /^a Merb-type project$/ do
  @project_name = "merb-project"
  create_project
  
  @migration_dir = "schema/migrations"
  create_dir(@migration_dir)

  create_file(
    "#{@migration_dir}/001_first_migration.rb", <<-RUBY
      # This is just a dummy migration file
    RUBY
  )
  
  create_file(
    "Rakefile", <<-RUBY
      namespace :db do
        task :imaginary_merb_reset_task do
          puts "Invoked: rake db:imaginary_merb_reset_task MERB_ENV=\#{ENV['MERB_ENV']}"
        end
      end
    RUBY
  )
  
  create_fake_test_case(
    :migration_directory => @migration_dir,
    :command_pattern => "rake db:imaginary_merb_reset_task MERB_ENV=%ENV%",
    :environment => "my_merb_env"
  )
end

Given /^a fake test case for the "([^"]*)" environment$/ do |environment|
  create_fake_test_case(:environment => environment)
end

Then /^the database should be reset$/ do
  Then %'I should see "Invoked: rake db:reset"'
end

Then /^the database should not be reset$/ do
  Then %'I should see "Skipping database reset"'
end

Then /^the database should be reset for the "([^"]*)" environment$/ do |environment|
  Then %'I should see "Invoked: rake db:reset RAILS_ENV=#{environment}"'
end

Then /^the database should be reset for the current Merb environment$/ do
  Then %'I should see "Invoked: rake db:imaginary_merb_reset_task MERB_ENV=my_merb_env"'
end

When /^I run a test case(?: again)?$/ do
  run("ruby fake_test_case.rb")
end

When /^I touch a migration$/ do
  sleep 1
  create_file(
    "#{@migration_dir}/001_first_migration.rb", <<-RUBY
      # Modified migration file
    RUBY
  )
end
