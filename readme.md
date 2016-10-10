# LoL Champions

> A minimal Roda app that consumes Riot's API for listing Champions and their recommended items

## Setup

```
# Install all dependecies
bundle install

# Setup database
bundle exec rake db:migrate

# Fetch Riot's data
bundle exec riot_static_data:all

# Startup application
bundle exec rackup
```
