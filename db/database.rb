database_url = "#{ENV['RACK_ENV'].upcase}.DATABASE_URL"

DB = Sequel.sqlite ENV.delete(database_url)
