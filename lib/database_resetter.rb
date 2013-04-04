require 'time'

class DatabaseResetter
  def initialize(options = { })
    # NOTE There are no features/specs to prove the defaults are present
    @environment      = options.fetch(:environment, ENV["RAILS_ENV"])
    @command_pattern  = options.fetch(:command_pattern, "rake db:reset RAILS_ENV=%ENV%")
    @files_to_watch   = "#{options.fetch(:migration_directory, "db/migrate")}/**/*.rb"
  end

  def reset_if_required
    if migration_dir.empty?
      puts "*** No migrations"
      return
    end

    if migrations_changed_since_last_database_reset?
      reset
    else
      puts "*** Skipping database reset (migrations not changed since last run)"
      puts "*** Run `#{reset_command}` if necessary, or touch a migration"
    end
  end

  private

  def database_reset_time_file
    "#{database_reset_dir}/#{@environment}"
  end

  def database_reset_dir
    "log/database_resetter/#{`hostname`}"
  end

  def ensure_database_reset_dir
    system "mkdir -p '#{database_reset_dir}'"
  end

  def reset
    puts "*** Resetting #{@environment} database"
    run_reset_command_or_raise
    log_database_reset_time
    puts "*** #{@environment.capitalize} database reset"
  end

  def migrations_changed_since_last_database_reset?
    most_recent_migration_file_change_timestamp > last_database_reset_timestamp
  end

  def most_recent_migration_file_change_timestamp
    migration_dir.map { |filename|
      File.mtime(filename)
    }.max
  end

  def last_database_reset_timestamp
    File.open(database_reset_time_file) do |file|
      Time.parse(file.readline)
    end
  rescue Errno::ENOENT
    Time.at(0)
  end

  def log_database_reset_time
    ensure_database_reset_dir
    File.open(database_reset_time_file, "w") do |file|
      file.puts(Time.new)
    end
  end

  def run_reset_command_or_raise
    raise "Command failed: #{reset_command}" unless run_reset_command
  end

  def run_reset_command
    system(reset_command)
  end

  def reset_command
    @command_pattern.gsub("%ENV%", @environment)
  end

  def migration_dir
    Dir[@files_to_watch]
  end
end