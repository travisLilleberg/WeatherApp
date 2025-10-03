class ForecastController < ApplicationController
  # GET /
  def index
    @zip_code = "02123"
    @cached = true

    @weather_data = Rails.cache.fetch("weatherbit:postal_code:#{@zip_code}", expires_in: 30.minutes) do
      forecast = Forecast.new(zip_code: @zip_code)
      @cached = false
      parse_weather_json(
        JSON.parse(forecast.get_current_forecast),
        JSON.parse(forecast.get_daily_forecast)
      )
    end
  end

  private

  ##
  # Extracts the information we actually use:
  # - temp from current forecast,
  # - high_temp, low_temp, date from daily forecast for today + 6 days
  def parse_weather_json(current_json, daily_json)
    output = { daily: [] }
    output[:temp] = current_json["data"][0]["temp"]

    i = 0
    daily_json["data"].each do |d|
      break if i >= 7
      output[:daily].push({
        valid_date: d["valid_date"],
        high: d["high_temp"],
        low: d["low_temp"]
      })

      i += 1
    end

    output
  end
end
