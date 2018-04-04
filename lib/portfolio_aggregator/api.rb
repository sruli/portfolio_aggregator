# frozen_string_literal: true

class PortfolioAggregator
  # Class for interacting with the Alpha Vantage API
  class Api
    ALPHA_VANTAGE_API_KEY = 'A0VJE31GDXVH333K'
    BASE_URL = 'https://www.alphavantage.co'

    def initialize(stock_symbol:)
      @stock_symbol = stock_symbol
      @connection = Faraday.new(url: BASE_URL) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def monthly
      @connection.get(
        '/query',
        function: 'TIME_SERIES_MONTHLY',
        symbol: @stock_symbol,
        apikey: ALPHA_VANTAGE_API_KEY
      ).body
    end

    def weekly
      @connection.get(
        '/query',
        function: 'TIME_SERIES_WEEKLY',
        symbol: @stock_symbol,
        apikey: ALPHA_VANTAGE_API_KEY
      ).body
    end

    def daily
      @connection.get(
        '/query',
        function: 'TIME_SERIES_DAILY',
        symbol: @stock_symbol,
        outputsize: 'full',
        apikey: ALPHA_VANTAGE_API_KEY
      ).body
    end
  end
end
