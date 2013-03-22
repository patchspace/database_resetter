# database\_resetter

Note: I used to use darcs as the source control tool for this project.
I decided to move to git as other people will find it easier to collaborate
on GitHub. As it was small enough, I decided to manually port it on a
one-git-commit-per-darcs-patch basis. So (in case you looked at the commit
history), no – I didn't write the entire thing in 20 minutes. (How I wish
I could code that fast.)

## Introduction

### What does it do?

database\_resetter is a small gem to handle automatically resetting
your test databases when developing a Ruby web app.

### Why do I want it?

Because you're sick of seeing "No column XXX in table YYY" or some such,
because your test database is out of sync with your migrations.  If you're
making a lot of database changes, this can save you a fair bit of time.

I've used this code almost unmodified in all of my clients' projects over
the last year or two.  Pretty much everyone that's seen it has said
it looked pretty handy, so I've bundled it up as a gem.

### How does it work?

database\_resetter writes timestamp files into _log/database\_resetter_
that track when the database was last reset.  It tracks them:

* per environment (eg test, cucumber)
* per hostname

Per-hostname tracking is done in case you use Dropbox/JungleDisk etc to sync
code between machines.  (Note: there are no features/specs to prove this works.)

What _isn't_ tracked is what directory / SCM branch you're in.  So if you switch
to a different working copy folder, or change eg Git branch, database\_resetter
may not run the migrations.  If you'd like this feature please contact me.

_The easiest way to make database\_resetter run is to touch a migration file._

### How is database\_resetter different from database\_cleaner?

Ben Mabey wrote [database\_cleaner](http://github.com/bmabey/database_cleaner) to
help with emptying a database between individual test cases.  database\_resetter is
designed to get the initial schema of a database in place before any test cases run.

Basically, you want both :-)


## Instructions

If you're working on a Rails app, and your tests are good to go after a
`rake db:reset`, then place the following code somewhere that
will get executed once per test run:

    DatabaseResetter.new.reset_if_required

Note: there are no features to prove this default call actually works :)  I've
always specified the options explicitly myself.  But the defaults should work with
Rails.  If not, let me know.

For instructions on specifying the options, see below.

### Changing the Rake task

If (like me), you don't use _schema.rb_ to regenerate databases,
you'll need your own Rake task.  I use one called `rake db:rebuild`,
which is currently:

    desc "Reset and re-migrate the database"
    task :rebuild do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
    end

To override the default command, specify the `:command_pattern` option:

    DatabaseResetter.new(
      :command_pattern => "rake db:rebuild RAILS_ENV=%ENV%"
    ).reset_if_required

See below for a description of `%ENV%`.

### Using a different framework

If you use a different web framework, you may have to specify a different
environment variable to switch the framework environment (eg `MERB_ENV`
or `RACK_ENV`).  To override this, specify both `:command_pattern` and
`:environment`, eg:

    DatabaseResetter.new(
      :environment => ENV["MERB_ENV"],
      :command_pattern => "rake db:reset MERB_ENV=%ENV%"
    ).reset_if_required

You may also need to specify a different migration file directory to watch, eg:

    DatabaseResetter.new(
      :migration_directory => "schema/migrations"
    ).reset_if_required

(You can, of course, combine all three.)

### RSpec

Put the call to `DatabaseResetter#reset_if_required` in _spec/spec\_helper.rb_.

### Cucumber

Put the call to `DatabaseResetter#reset_if_required` in
_features/support/env.rb_.

### Spork

If you use Spork, you want to call `DatabaseResetter#reset_if_required` in the
`each_run` block, eg:

    Spork.each_run do
      # ...
      DatabaseResetter.new.reset_if_required
      # ...
    end

### PostgreSQL

If you use PostgreSQL, and your Rake task attempts to drop the database,
Postgres will stop you if there is a connection in place.  You need to work
around this somehow.  If you're using Spork, you need to divert Postgres's
eyes, eg in Rails:

    Spork.each_run do
      # ...

      ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
      DatabaseResetter.new.reset_if_required
      ActiveRecord::Base.establish_connection(config)

      # ...
    end

If you're not using Spork, you still need to make sure you call
`DatabaseResetter#reset_if_required` before connecting to the database.
One way of doing this with Bundler is to define a Bundler group just
for database\_resetter in your Gemfile:

    group :database_resetter do
      gem "database_resetter"
    end

And then use this to load and run database\_resetter before anything connects
to the database.  eg with Rails and Cucumber, in _env.rb_:

    # ...

    require 'bundler'
    Bundler.setup(:database_resetter)
    require 'database_resetter'
    DatabaseResetter.new.reset_if_required

    require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

    # ...


## Bugs / Feedback

There is currently no project page for database\_resetter.  If you want to report
bugs in the code or documentation, or request features, please contact me:

[ashley.moran@patchspace.co.uk](mailto:ashley.moran@patchspace.co.uk)

[PatchSpace Ltd](http://www.patchspace.co.uk/)


## Source code

database\_resetter is maintained in a darcs repository, and is currently hosted
on Patch-Tag:

[Official darcs repository](https://patch-tag.com/r/ashleymoran/database_resetter/)