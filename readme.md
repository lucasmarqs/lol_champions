# LoL Champions

> A minimal Roda app that consumes Riot's API for listing Champions and their recommended items

## Setup

You must have a [Riot Development API Key](https://developer.riotgames.com) before setup the application.

```
# Install all dependecies
bundle install

# Create .env file
bundle exec rake setup\[RIOT_KEY\]

# Setup database
bundle exec rake db:migrate

# Fetch Riot's data
bundle exec rake riot_static_data:all

# Startup application
bundle exec rackup
```
