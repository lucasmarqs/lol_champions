ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require_relative "environments/#{ENV['RACK_ENV']}"

Dir['./tasks/**/*.rb'].each { |file| require file }

task :setup, [:riot_key] do |t, args|
  if args[:riot_key].nil?
    $stderr.puts "You must pass your Riot ID as argument!"
    exit(1)
  end

  File.write '.env', <<~TXT
    RIOT_KEY="#{args[:riot_key]}"
    DEVELOPMENT.DATABASE_URL="db/development.db"
    TEST.DATABASE_URL="db/test.db"
  TXT
end

namespace :assets do
  task :precompile do
    LolChampions.compile_assets
  end
end

task :default do
  exec "bundle exec rspec spec"
end
