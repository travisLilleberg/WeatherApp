require 'rails_helper'

RSpec.describe Forecast, type: :model do
  it "is valid with a valid zip code" do
    expect(Forecast.new(zip_code: '55955')).to be_valid
  end

  context 'Should not be valid' do
    it "is invalid without a zip_code" do
      expect(Forecast.new(zip_code: nil)).to_not be_valid
    end

    it "is invalid with an invalid zip_code" do
      expect(Forecast.new(zip_code: '1')).to_not be_valid
      expect(Forecast.new(zip_code: '1343')).to_not be_valid
    end
  end
end
