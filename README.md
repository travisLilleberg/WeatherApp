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

## Decomposition
The task breaks down into 6 parts

### Retrieving API data
This logic could have been in a library class, but I felt it was more clear to keep it in the model. ActiveModel is usually used to access the data store so I kept with that paradigm. ActiveModel has been decoupled from ActiveRecord, so keeping with the MVC design was the most straightforward design choice.

### Parsing API data
A controller is the obvious place for this logic, as it retrieves the data from the model and then passes it to the views, like a standard MVC app.

### Displaying parsed data
Similar to the controller, views are the obvious choice for this, so to stick with the MVC design pattern.

### Caching parsed data for 30 minutes
Using the built-in Rails.cache took no setup and was able to meet all the requirements for this task. No reason to make it more complicated.

### Maintaining secret API key
I access the weatherbit API via an API key. Using Dotenv was as simple as adding it as a bundle and then creating a .env file. Developers will need to generate their own key and put it in a .env file or get the API key from the team.

### Testing application
I chose Rspec over Minitest here because that's what I'm most familiar with, and from my experience, more widely used. The task had a set time limit so I saved time by using the library that I already knew. I did make sure to set up Github CI to run Rspec instead of Minitest.

## Versions
* Ruby 3.4.6
* Rails 8.0.3
* Weatherbit 2.0