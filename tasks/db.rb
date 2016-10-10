namespace :db do
  task :migrate do
    check_valid_arguments! :migrate

    database_url = ENV["#{current_environment.upcase}.DATABASE_URL"]

    exec "bundle exec sequel -m db/migrates sqlite://db/#{current_environment}.db"
  end

  task :drop do
    check_valid_arguments! :drop

    exec "\\rm db/#{current_environment}.db"
  end


  def check_valid_arguments!(task_name)
    if ARGV.size > 2
      $stderr.puts "Usage: rake db:#{task_name} {environment}"
      exit(1)
    end
  end

  def current_environment
    env = ARGV[1] || "development"
  end
end
