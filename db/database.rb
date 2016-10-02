DB = Sequel.sqlite(ENV.delete('DATABASE_URL'))
