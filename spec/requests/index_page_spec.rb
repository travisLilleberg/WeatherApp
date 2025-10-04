require 'rails_helper'

RSpec.describe "Index Page", type: :request do
  it "Renders the index template" do
    get "/"
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:index)
    expect(response.body).to include("Weather Forecast")
    expect(response.body).to include("Enter a zip code")
  end

  it "Does not render weather information before zip code is provided" do
    get "/"
    expect(response.body).not_to include("Current Temperature:")
  end

  it "Displays weather info when given a zip code" do
    allow_any_instance_of(Forecast).to receive(:get_current_forecast).and_return("{\"data\":[{\"temp\":68}]}")
    allow_any_instance_of(Forecast).to receive(:get_daily_forecast).and_return(
      "{\"data\":[{\"high_temp\":72,\"low_temp\":62,\"valid_date\":\"2025-10-04\"}]}"
    )

    get "/", params: { zip_code: '58102' }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:index)
    expect(response.body).to include("Current Temperature: 68")
    expect(response.body).to include("High: 72")
    expect(response.body).to include("Low: 62")
  end
end
