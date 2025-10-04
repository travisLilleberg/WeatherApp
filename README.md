# This is Travis Lilleberg's basic weather application.

This app is designed, with minimal styling, to provide the current temperature and 7 day forecast for any given American zip code. Results are cached per zip code for 30 minutes after initial request.

## To deploy
* Clone this repository to your local
* Create an .env file with a WEATHERBIT_KEY set to a valid API key
    * I will provide this for testing
* bin/rails server

## APIs used
This app uses the Weatherbit 'current' and 'daily' APIs:
* https://www.weatherbit.io/api/weather-current
* https://www.weatherbit.io/api/weather-forecast-16-day

## No Database
This app has no need for persisting any data beyond 30 minutes, which is something the Rails cache can already do. So ActiveRecord is not set up by default. ActiveRecord is installed, however, for possible future development.

## How to run the test suite
This app uses Rspec instead of Minitest. Minitest files have been removed. Github CI has been set to run Rspec instead.
* bundle exec rspec

## Versions
* Ruby 3.4.6
* Rails 8.0.3
* Weatherbit 2.0