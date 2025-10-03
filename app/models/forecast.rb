require "net/http"

##
# Retrieves forecast information given a zip code.
class Forecast
    include ActiveModel::Validations

    attr_accessor :zip_code

    validates_presence_of :zip_code
    validates :zip_code, format: { with: /\A\d{5}\z/, message: "Invalid zipcode" }

    def initialize(attributes)
        @zip_code = attributes[:zip_code] if attributes[:zip_code] != nil
    end

    def get_current_forecast
        send_request("current")
    end

    def get_daily_forecast
        send_request("daily")
    end

    private

    ##
    # Sends a HTTPS request with provided endpoint.
    def send_request(endpoint)
        Net::HTTP.get(URI(baseurl + endpoint + "?" + query_params + @zip_code))
    end

    ##
    # The base url for the Weatherbit API
    # https://www.weatherbit.io/api/weather-forecast-16-day
    def baseurl
        "https://api.weatherbit.io/v2.0/forecast/"
    end

    ##
    # Query parameters to pass on the API request.
    def query_params
        "country=US&units=I&key=" + Rails.application.credentials.weatherbit[:key] + "&postal_code="
    end
end
