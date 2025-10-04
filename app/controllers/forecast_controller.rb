class ForecastController < ApplicationController
  # GET /
  def index
    if params[:zip_code]
      @cached = true
      @zip_code = params[:zip_code]

      @weather_data = Rails.cache.fetch("weatherbit:postal_code:#{params[:zip_code]}", expires_in: 30.minutes) do
        forecast = Forecast.new(zip_code: params[:zip_code])
        @cached = false
        parse_weather_json(
          JSON.parse(forecast.get_current_forecast),
          JSON.parse(forecast.get_daily_forecast)
        )
      end
    end
  end

  private

  ##
  # Extracts the information we actually use from the API data
  # - temp from current forecast,
  # - high_temp, low_temp, date from daily forecast for today + 6 days
  def parse_weather_json(current_json, daily_json)
    output = { daily: [] }
    if !current_json.empty?
      output[:temp] = current_json["data"][0]["temp"]
    end

    if !daily_json.empty?
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
    end

    output
  end
end
